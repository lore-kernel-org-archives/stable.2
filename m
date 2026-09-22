Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75A235BE2;
	Tue, 22 Sep 2026 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059082; cv=none; b=VmRr/n+DTP6bdJ9IV2IRMFzig9OvTXUjvvMwQHWqQdJt+Q6qPaOtt+TbcnRkr7yWKUkVg/TiVOICOJAhC/WPvkVZQk895vNBBwNHLqRRUVHYu2MlKjgsI1NqZLWv0/BOhqHSRHCJFI5QI9sZFVduP+3uU/VfbxGK6TCMoTA+MPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059082; c=relaxed/simple;
	bh=FDhJQCuEB++mx1er2zWIMUM+gcUWH+FHoZ6obqOmxdc=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=bJg3AiQbMFQTXhKwpDJbqaGbyQYYThueC4SVFHBJuJHNbU7m4KVcJ5Xzg+e+Mhl8Wi866zYlLFGlfm5kp1ARa1YwPJaywPlTfscUtY08np5VfXwj37dYb883uo9nVbz6058humW/5upDhg3/020rZZTP3Qb7mllEgseYlYW+cmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=gtIVZlRS; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ssvvg044; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="gtIVZlRS";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ssvvg044"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790059077; bh=zOpPmSCNLlSxuFoNAmMVUyv
	oe4BYgBbBcWc1Tjwbh6o=; b=gtIVZlRSpyaTMx/H5v7ViF1Sz7J1YIgGYaR+53YalJ93vdEhyn
	w4q/v95uvXLD0dSxIHlS9RDDuvJPNYOtfftZm8G2ovEmgsokRayAhRYyaQtIC7WDaAFgGUdHTal
	uweveLl93HaYlWtcoJPO7CprTiDtxscu/dAeaTKPeTGiI8cqqg/UlubbTgrY7OejEe2dCHYpZeM
	N1jsyL82iED5x23jorwyYbU0zmpobsvwcaAyvJDBl0RCxuLNR6XTsct5Ics6shtl4Yl4IjjI3V8
	RhFkaUQzf9uHpH1qTVL29lF7mTlR1i34L3Afq/g42owv0hgbz8mmWbz/wBuGpxI/2Lg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790059077; bh=zOpPmSCNLlSxuFoNAmMVUyv
	oe4BYgBbBcWc1Tjwbh6o=; b=ssvvg044eWrqNQ8nPa8wDcW7PZ3ac626SMZg7FIw+GObwr2l20
	k7FC+H3Sjzf6T3Y3xtK4A6iOFg4/hGALWbBg==;
Date: Tue, 22 Sep 2026 07:37:57 +0100
From: Bradley Morgan <brads@mainlining.org>
To: zhanxusheng1024@gmail.com
CC: joel.granados@kernel.org, kees@kernel.org, kuniyu@google.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, zhanxusheng@xiaomi.com
Subject: Re: [PATCH 1/2] sysctl: Negate before converting in the int read path
In-Reply-To: <20260922031229.2300283-2-zhanxusheng@xiaomi.com>
Message-ID: <867A30A7-5460-4988-A078-09D0B4BCD44C@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 September 2026 04:12:27 BST, Zhan Xusheng <zhanxusheng1024@gmail.com>
wrote:
>proc_int_k2u_conv_kop() reports the sign through *negp and the magnitude
>through *u_ptr, but for a negative value it hands the sign-extended int to
>the converter and negates the result:
>
>	*u_ptr = k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;
>
>With div_hz() and HZ=1000 a stored -1000 becomes
>(ulong)-1000 / 1000 == 18446744073709550, and negating that wraps:
>
>	# echo -1 > /proc/sys/net/ipv4/tcp_fin_timeout
>	# cat /proc/sys/net/ipv4/tcp_fin_timeout
>	-18428297329635842066
>
>Take the magnitude first and convert that, which is what the open-coded
>version did before commit 2dc164a48e6f ("sysctl: Create converter
>functions with two new macros") folded it into a macro.  The
>k_ptr_op == NULL branch was already correct.
>
>proc_dointvec_jiffies() and proc_dointvec_ms_jiffies() are affected.
>
>Fixes: 2dc164a48e6f ("sysctl: Create converter functions with two new macros")
>Cc: stable@vger.kernel.org
>Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
>---
> kernel/sysctl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>index f7b75985d542..38597f26b34c 100644
>--- a/kernel/sysctl.c
>+++ b/kernel/sysctl.c
>@@ -483,7 +483,7 @@ int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
> 
> 	if (val < 0) {
> 		*negp = true;
>-		*u_ptr = k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;
>+		*u_ptr = k_ptr_op ? k_ptr_op(-(ulong)val) : -(ulong)val;
> 	} else {
> 		*negp = false;
> 		*u_ptr = k_ptr_op ? k_ptr_op((ulong)val) : (ulong) val;
>
I didn't do much crazy review here, but I think this LGTM! :)

Reviewed-by: Bradley Morgan <brads@mainlining.org>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
