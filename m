Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD842EEE69;
	Mon, 29 Jun 2026 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741190; cv=none; b=JLVwL2+ozHJdIkOqT+0cHyzoMUwSCHlDqIbhrvzxta2aJDIMYmmrcxp2TRE2pxptVw+KImegmoQNbuO/BDZ49GpOUG4Vn0BJaDJalhMjsJXjH/BD7MhE2M92Oj2/r9HK4yLTd6vs0D86q6IPTi8x5MGgGQD1O8mqu7nMudpB7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741190; c=relaxed/simple;
	bh=lnB4yqZN5higwo+FbocY+bJA/QMc8Fx00nxu9JFZ4Jo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BlZs+YtgmU87ic45sTMQk2dNmhbzg1iT8PHy/HoCNV+yWKZ/KBZYP7v43XOi1YE/uzHjabytMh1kg5MX9JtAicDjajabUGbSyYGe6N9YtVX+tMLqUIjq2WCmBFanhAZhct5FrzCgyGZgtBDPE9DZ2Gw/isvbpbAuXrkBLfjvs0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=mBtDYa+N; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="mBtDYa+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782741187;
	bh=ts8JWNes5ZRZzzb0SQA7k3h7t9QaCSSjPcBO5U8rQNA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mBtDYa+NjFOb+O0dK2Hiz8D3EVreU2EAEYgKkzQTv32JYKB4KDhy2in/gzPAeL1X2
	 1LIUT8Il7gtGdgGdqNGIgDJR6H1v/CFi/qkBCw988wBrbW9QO3EkOgqbqlu7eL0O8S
	 Zskr2E9jQ3W1wk7zPlcplfqBQRNd5m/ekeB8WEfo=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gpnmM2BVjz110s;
	Mon, 29 Jun 2026 13:53:07 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gpnmL6pPxz10xs;
	Mon, 29 Jun 2026 13:53:06 +0000 (UTC)
Date: Mon, 29 Jun 2026 14:53:05 +0100
From: Bradley Morgan <include@grrlz.net>
To: Breno Leitao <leitao@debian.org>
CC: akpm@linux-foundation.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_lib/bootconfig=3A_fix_undefined_?=
 =?US-ASCII?Q?behavior_involving_NULL_pointer_arithmetic?=
In-Reply-To: <akJ0f2gsiEt01spu@gmail.com>
References: <20260628115617.3190-1-include@grrlz.net> <akJ0f2gsiEt01spu@gmail.com>
Message-ID: <0B594835-45AD-4B37-85A3-C7F54F8D668A@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 29 June 2026 14:41:37 BST, Breno Leitao <leitao@debian.org> wrote:
>On Sun, Jun 28, 2026 at 11:56:16AM +0000, Bradley Morgan wrote:
>> When xbc_snprint_cmdline() is called during the size-probing phase
>> (with buf = NULL and size = 0), the function computes the end pointer
>> as 'buf + size' (NULL + 0) and repeatedly advances the pointer via
>> 'buf += ret'.
>> 
>> Under the C standard, performing pointer arithmetic on a NULL pointer is
>> undefined behavior. While harmless inside the kernel, this code is also
>> compiled into the userspace host tool 'tools/bootconfig', where host
>> compilers with UBSan or FORTIFY_SOURCE enabled abort the build when they
>> detect NULL pointer arithmetic.
>> 
>> Fix this by tracking the running written length as an integer offset
>> ('len') rather than advancing 'buf' directly. Only perform pointer
>> arithmetic if 'buf' is actually non-NULL.
>> 
>> Fixes: 5a643e462323 ("bootconfig: move xbc_snprint_cmdline() to
>lib/bootconfig.c")
>
>Isn't commit 5a643e462323 ("bootconfig: move xbc_snprint_cmdline() to
>lib/bootconfig.c") just a code movement?

Ugh, Geminis bullcrap, you are right. I should've just manually looked
for the fixes tag (as I always do)

>>  	xbc_node_for_each_key_value(root, knode, val) {
>> @@ -439,10 +437,12 @@ int __init xbc_snprint_cmdline(char *buf, size_t
>size, struct xbc_node *root)
>>  
>>  		vnode = xbc_node_get_child(knode);
>>  		if (!vnode) {
>> -			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
>> +			ret = snprintf(buf ? buf + len : NULL,
>> +				       size > len ? size - len : 0,
>
>Why not keeping rest() and updating it, instead of open coding it?
>
>Thanks for the fix.

sure I'll do V2, btw if u didn't read, gemini found and fixed this.
As in fully. :)



>--breno
>

Thanks!
