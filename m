Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF1292B4B
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396236; cv=none; b=MJVJyw5eEedDHUox9ST6Wjpn318fjQIVpGWMq30WlQwb2XKvfovRW7HqehML4hg9zOcsstg2zadWj48XuHZWcXXDvdDbLYmLD2Rm7097RbVE4Df3FoUysNcHTSlFryQQmE0S6Q8ZUwwXYd5NUIOQZ2aiZpshN6BgzceGIDSEuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396236; c=relaxed/simple;
	bh=SW2Goo4rC3spCqQexUxOpucCwXM94gSy77m8ajd8jMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxl9GLtk6mkee5CWH9yjx4c7I3CV439IqJRkT7d/tCyvutE7D1RbrObnl0khZ308UlPfirgvajdhm/yXqLCGfURMU86NWibHKkZRiiLqXGIrnSHTiyRVHqsTDXbb3Y4W+s+r/oEU/V0LsfKClFZ4PAINAzyS7EOzSxDVVmWIzuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XLZ+FSrM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XLZ+FSrM"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4629051c946so716722f8f.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782396233; x=1783001033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXePbhpqmqUIpWXHZ6AhrPzihy8SICwPudmPEVZUNGU=;
        b=XLZ+FSrMQB+zEUxMyAW61ZKuNRiZ1uzNsvRATf0bjKP8ldQvUPdl/gO/LAUXNWuind
         j/rqJM7fE+zFbroaCaygN7OZmL1A5GHLOXWF94EOWbSjcHGbWZW+hkc3ORcGpYtsR8SZ
         8GKUf8+S3AfbaSoVL57d1GSye82d26OpOhjzzqQooP4WmR46mPIjfDciN0TAP6zgtHNF
         yr8syReCb3hLTaDPY7UW5oMu7TQoktz34vOSs40pbUad5Caa7jnHimj/RfK1xPoVaHY1
         X2KUWgV5x16gqSyivit5cW1vpB8FT8DvSD+swQjkMwb0MQUECM6guVex1l16MU9aDW/W
         ccvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782396233; x=1783001033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXePbhpqmqUIpWXHZ6AhrPzihy8SICwPudmPEVZUNGU=;
        b=i3K29frux+PwoZKjJbNoaOq7hH9tbvc/fkBECaYZGg60OkGPqFuO7LIJTyjx041AK+
         CvrcKA/P10M5f7IsbmDbdzT6YjI17v+hM0pKL867s4XsUfFCdJdUi4hsboWuzZf/MYyH
         Jwi79nL4urQT/OuxoCdvNlCBNpAPTJXISMkTifpR2H9KlWwVq+atzidFaEtKHuMyWylW
         Ihba8vOYGOk7SRP6CJBiV1TXXGYVWPpKbkSCbPvhs25gtTaUt4Grm0pBXkuOwMTx8lmJ
         bALRMKhwKBvA99A9kRkTERGIQh2lm/5duJe79EMg6IMocQGtW8DB5ZZfKuTLrRIg9NL9
         RH9w==
X-Forwarded-Encrypted: i=1; AHgh+RrQpgmrXVtorXClrmr/2Sqq2bTrAu5xnSo06qIsY/q+s0lMhkYBeD2mU1s6zv0UPB7Om4QrJRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xNHzfhOV849dqv1w0ylm98lQmKprN1LyNjhCdMjk17IY7Rp3
	TtycplFzLfmUusovKwUPZGToJqa85fr09vaRkgCcdA5V2XTuDGHerTJO3zxn2NbvjlQ=
X-Gm-Gg: AfdE7cnfQAJP7eZX7opTjuAE7XfqqN/tcHJn5OEvUw8cNfTjabq47ORzmDxscLrYi5F
	fHDBJuiubMPK/kQkkPN/yDwsBBkM4ZAA2r5JpQDqqYs3Sppq34/5BBCm5HhGoD8mAdwvR9HXjeU
	THOKFUuTVOBNH5KBxUgAHi762YU5WKfFkzBFHDeyxZmt/ZeTZx4jhXkWGnSHrImfs3o22jbZNIS
	tzBlUKAC7iIuY3ysJWNz4WFsgtHFNAjzmetCLLqpRMgzwoyWr1rj990eYVYK2+k0SWaUplyZdDZ
	YmhgC4qmuGJOZ02jFr65C8cLP3VVwsNjtvbDY3xUGKupGpTAr2RTIQxRfH3uuKSrypbv69oaJ3v
	mHbgUXBYX6LkNCDy018qY6j1QgB4XtI4Zc4m6htFuBvva+CEHTmDM60CPbzgEnCsdcQJaw5PHtn
	RL
X-Received: by 2002:a5d:5f4d:0:b0:460:395c:7404 with SMTP id ffacd0b85a97d-46da9aceb40mr4346600f8f.20.1782396232681;
        Thu, 25 Jun 2026 07:03:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46d86960983sm7584574f8f.4.2026.06.25.07.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 07:03:51 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:03:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] sys_info: add helper for callers that handle
 all_bt
Message-ID: <aj01RHgagZm83dFq@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>

On Tue 2026-06-23 15:34:58, Bradley Morgan wrote:
> Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> Add a helper that strips that bit without turning an all_bt only mask into
> a kernel_sys_info fallback.
> 
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
> Changes since v1:
> - New patch for the shared helper suggested by Petr.
> 
>  include/linux/sys_info.h |  1 +
>  lib/sys_info.c           | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
> index a5bc3ea3d44b..87a841ec7b6a 100644
> --- a/include/linux/sys_info.h
> +++ b/include/linux/sys_info.h
> @@ -18,6 +18,7 @@
>  #define SYS_INFO_BLOCKED_TASKS		0x00000080
>  
>  void sys_info(unsigned long si_mask);
> +void sys_info_without_all_bt(unsigned long si_mask);
>  unsigned long sys_info_parse_param(char *str);
>  
>  #ifdef CONFIG_SYSCTL
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index f32a06ec9ed4..6afd4c697633 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -164,3 +164,18 @@ void sys_info(unsigned long si_mask)
>  {
>  	__sys_info(si_mask ? : kernel_si_mask);
>  }
> +
> +void sys_info_without_all_bt(unsigned long si_mask)
> +{
> +	unsigned long dump_mask = si_mask & ~SYS_INFO_ALL_BT;
> +
> +	/*
> +	 * Do not call sys_info() when the caller context required only
> +	 * backtraces from all CPUs. Otherwise sys_info() would fall back
> +	 * to the generic kernel_si_mask.
> +	 */
> +	if (si_mask && !dump_mask)
> +		return;
> +
> +	sys_info(dump_mask);
> +}

Sashiko AI pointed out that this function still migth trigger printing
duplicate backtraces when (si_mask == 0). It calls sys_info(0)
which falls back to kernel_si_mask which might have SYS_INFO_ALL_BT
bit set, see https://sashiko.dev/#/patchset/9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include%40grrlz.net

=> we need to eventually disable the SYS_INFO_ALL_BT bit also
   in kernel_si_mask.

I think about creating a generic API which would allow to apply
a filter mask, something like:

From 02fc810a801adc0fc4d1fd14318415719bdfc656 Mon Sep 17 00:00:00 2001
From: Bradley Morgan <include@grrlz.net>
Date: Tue, 23 Jun 2026 15:34:58 +0000
Subject: [PATCH 1/4] sys_info: add helper for callers that print some
sys_info on their own

Some callers print some sys_info on their own before calling sys_info().
Add a helper which would allow to prevent a duplicated output.

It is a bit tricky because kernel_si_mask should be used only
when the call-specific si_mask is empty. But the duplicated
output must be prevented there as well.

Signed-off-by: Bradley Morgan <include@grrlz.net>
Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup") ?
Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
---
 include/linux/sys_info.h |  1 +
 lib/sys_info.c           | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
index a5bc3ea3d44b..f1c2552ca3d1 100644
--- a/include/linux/sys_info.h
+++ b/include/linux/sys_info.h
@@ -18,6 +18,7 @@
 #define SYS_INFO_BLOCKED_TASKS		0x00000080
 
 void sys_info(unsigned long si_mask);
+void sys_info_with_filter(unsigned long si_mask, unsigned long si_ignore_mask);
 unsigned long sys_info_parse_param(char *str);
 
 #ifdef CONFIG_SYSCTL
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..d411fee10415 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -136,8 +136,10 @@ static int __init sys_info_sysctl_init(void)
 subsys_initcall(sys_info_sysctl_init);
 #endif
 
-static void __sys_info(unsigned long si_mask)
+static void __sys_info(unsigned long si_mask, unsigned long si_ignore_mask)
 {
+	si_mask &= ~si_ignore_mask;
+
 	if (si_mask & SYS_INFO_TASKS)
 		show_state();
 
@@ -160,7 +162,21 @@ static void __sys_info(unsigned long si_mask)
 		show_state_filter(TASK_UNINTERRUPTIBLE);
 }
 
+void sys_info_with_filter(unsigned long si_mask, unsigned long si_ignore_mask)
+{
+	unsigned long dump_mask = si_mask & ~si_ignore_mask;
+
+	/*
+	 * Do not fall back to kernel_si_mask when the caller context
+	 * required only the ignored information.
+	 */
+	if (si_mask && !dump_mask)
+		return;
+
+	__sys_info(dump_mask ? : kernel_si_mask, si_ignore_mask);
+}
+
 void sys_info(unsigned long si_mask)
 {
-	__sys_info(si_mask ? : kernel_si_mask);
+	sys_info_with_filter(si_mask, 0);
 }

The next patches might use sys_info_with_filter(si_mask,
SYS_INFO_ALL_BT) instead of sys_info_without_all_bt(si_mask).

Feel free to bike shed about the function name. Also I am not
sure whether to pass the filter as bits to filter or already
the complement (~mask).

Best Regards,
Petr

