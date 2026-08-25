Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941D3E00AA
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649081; cv=none; b=jgT3GG1QHQiYnyIqAFaGbpbiVoSZs0gZVGupIdz0g+c/grr656hDKIj7LCQb2atsE2xCrsvatNDaqtwLDCfSY2+iUFS/aBc5umjZmUmaUUIuMKWiIIlRX8CLR/OJZ+JBswFVOMHOXAShmSFcGVvbvkIkanCyUleRUijMs1bU8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649081; c=relaxed/simple;
	bh=tQEWaKE/wh78V7ecDhceF4ssI56SP4PKEbQQgOg7yio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmHHeBvdl+iz9KEg/x7zY/HBDIwqDsK2UYUcBwM9TFVUQx95P+tMWddABogvQSFYFWr+UIrfjorsRCvYEfvYvrEY1a9/8QPPKFeIY0xGlORBnNmWvLUuXd7WE6bYfRs/v4EMxa3pP121RTthpTUfCNzt8jPdxpi0JJr2+j0juk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QDjigP82; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QDjigP82"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2055f5a993so505444166b.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787649077; x=1788253877; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0mlwi5/eUS/zccQyXyc1naDz4zuh23kT0Olm9HhiAUM=;
        b=QDjigP82HyY1UZgYIyJVDS7zzL36XKHjkKbN2b8/zbSxIq1/q9VGOJ4QU8McaNzsNQ
         bpfM355OIsjQeGkvhvaMnckGm/oGx5hqrZYPDnR6mLbalppKpxaRyVBCXy1aD2Bm2Lvt
         wyCEg43l7snDG+HuTk3RP8HsyxFTSi3n8unhOAgBtS81WgF6PW7JIbVcXES7LbV/qUgw
         U7aj1QDKC/mvxr4mRW3beNgYJ0uJEHjsstbLUs97Y1ckEjYTF2RZoTOF1vahZiRYtd5U
         qFXULGgEN6/fUdNApbsII61w1yjj0fvqTQL1OpMytsmsT95HcMx9zzqgndSxU0OkpLoZ
         pNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649077; x=1788253877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0mlwi5/eUS/zccQyXyc1naDz4zuh23kT0Olm9HhiAUM=;
        b=T1mpy7HxpTmL8zAbCbkTfz5AuNTIHbXK8Kzj72B7Tou7NbmhrUrDxKcVbTF7SCdAV9
         zRXJPTim4IjuFaLZp8avJoyAHtx/Cb7K2iTDMNJrE1OdjqaEX10P0miNn3Q800DYdpur
         ZPauNeqn6k1+BACu3K/gMJwYkCJHaUkhfjuswWHwdP8SbVXghPRw8km/jsyC+W25fWV0
         BibxR+fHLEU/6LcosJ72CD3QcMmsEFBualP4NZVtb2cnFq+OKaPcd8NW6pMCUCZQ5v5P
         mcvFTeTSMi73MjVXj/txLGV3fPRH81bXGeZ7scpMdDAGOFghJZ+mgWAS84Ys+DGMKUcx
         CCrw==
X-Forwarded-Encrypted: i=1; AHgh+RoafAQajztEnKtvY21KEK8xb3ftTPfEDI9H1/c1iWmNGuYoJSfvHV2CbnqH7oKbdBuqAyMp5qo=@vger.kernel.org
X-Gm-Message-State: AFuF++ltRDooJ72oc8Gk3p0rZHbw3BsH4TP2gC2QZtCH7rVoR1aoyX06
	jcU1SgukoSgvxn/nxAD194dy5N9KqIAVRaoGeTN24IBhJanEiGIJ/0zS2qsR6fP8pzA=
X-Gm-Gg: AR+sD11HSI+fRdjXGT2yfYEvg6+ylVu2gbT0KOaP4IGl3TIPWzfmjOakUHKXptEE553
	N71WvhNwGIU0m5dsDJqWyMfltbT2WqnUDW1W8kfBVMKD6ODOjNX5B95gGFcaYRQ0dU6afC+wDPJ
	8CGE+717i/IrYvQo+gRmQYQO5o5NH21gXMHPyixiUZa3lgGUfLFSeKhSXC07p9Ixo8g94GA7B/4
	nsl9ZvcNJZKGwTqsJYNlsJUMh8EpNaCSH+jn1KW+1ry/isAu1Obj0d4QFhYs9WiZ6OPEBa6UTju
	o6s/63hsJ7gg+9RbwWzV3H2rLoZUwzNnFbaalimJCGjwW/u4UHMwTRH5iJ4K8vXUAjwy1j5MX3H
	RqQAQdcitY2rDZNTV0scGfppLT57YvChqD1eY3de9b9YuIJvlP0W6/jfer4u4VQPfI868/Bd36G
	nPUAuuLMdbFd5cvDohDaPVj9RxxRlRXVaAhrRDnrNYLcxRuPbocDoyYmSVo2qF2A==
X-Received: by 2002:a17:907:3e98:b0:c16:8adf:f183 with SMTP id a640c23a62f3a-c24e5fc4f6emr562080166b.14.1787649077567;
        Tue, 25 Aug 2026 02:11:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249673d43bsm1574630266b.47.2026.08.25.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:11:17 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:11:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 4/6] panic: restore variable arguments to nmi_panic()
Message-ID: <ao1cMllk_v6uQDqL@pathway.suse.cz>
References: <20260818163806.17460-1-include@grrlz.net>
 <20260818163806.17460-5-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818163806.17460-5-include@grrlz.net>

On Tue 2026-08-18 16:38:04, Bradley Morgan wrote:
> nmi_panic() used to accept variable arguments until commit
> ebc41f20d77f ("panic: change nmi_panic from macro to function")
> flattened it to a final message string. vpanic() did not exist back
> then, so the function had to format through panic("%s", msg).
> 
> Bring the variable arguments back and format with vpanic() directly.
> The next patch makes nmi_panic() try the panic_force_cpu= redirect
> before claiming panic_cpu, which needs the arguments twice: once to
> format the message for the redirected CPU and once for vpanic() when
> no redirect happens. Passing a final string would lose that.
> 
> Every existing caller passes a plain string literal with no format
> specifiers, so nothing changes for them.

Sashiko AI complains, see
https://sashiko.dev/#/patchset/20260818163806.17460-1-include%40grrlz.net

| Is this assertion accurate? Looking at hpwdt_pretimeout() in
| drivers/watchdog/hpwdt.c, it constructs a dynamic string before passing it:
| 
| drivers/watchdog/hpwdt.c:hpwdt_pretimeout() {
| 	...
| 	hex_byte_pack(panic_msg, nmistat);
| 	nmi_panic(regs, panic_msg);
| 	...
| }

It is true that @panic_msg is a pointer to a string. But there
are only two variants and both are plain strings with no format
specifiers.

Well, we will update the commit message anyway, see below.

> Signed-off-by: Bradley Morgan <include@grrlz.net>


> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -13,7 +13,8 @@ __printf(1, 2)
>  void panic(const char *fmt, ...) __noreturn __cold;
>  __printf(1, 0)
>  void vpanic(const char *fmt, va_list args) __noreturn __cold;
> -void nmi_panic(struct pt_regs *regs, const char *msg);
> +__printf(2, 3)
> +void nmi_panic(struct pt_regs *regs, const char *fmt, ...);

Here Sashiko says:

| Will this __printf() annotation cause a -Wformat-security build failure in
| hpwdt_pretimeout() when compiled with CONFIG_HPWDT_NMI_DECODING, since
| panic_msg is passed directly as the format argument without a "%s"
| specifier?

And it is right. I have reproduced it. I have explictitely
added -Wformat-security and got:

# CC      drivers/watchdog/hpwdt.o
drivers/watchdog/hpwdt.c: In function ‘hpwdt_pretimeout’:
drivers/watchdog/hpwdt.c:202:9: warning: format not a string literal and no format arguments [-Wformat-security]
  202 |         nmi_panic(regs, panic_msg);
      |         ^~~~~~~~~

So, we should add the %s format to be on the safe side.
The following works:

--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -199,7 +199,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	}
 
 	hex_byte_pack(panic_msg, nmistat);
-	nmi_panic(regs, panic_msg);
+	nmi_panic(regs, "%s", panic_msg);
 
 	return NMI_HANDLED;
 }

We should do this change in this patch and mention it in
the commit message which should prevent the earlier
complaint.

>  void check_panic_on_warn(const char *origin);
>  extern void oops_enter(void);
>  extern void oops_exit(void);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 6b5728c3c9ce..bc142485faa4 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -518,13 +518,20 @@ EXPORT_SYMBOL(panic_on_other_cpu);
>   * nmi_panic_self_stop() which can provide architecture dependent code such
>   * as saving register state for crash dump.
>   */
> -void nmi_panic(struct pt_regs *regs, const char *msg)
> +__printf(2, 3)

This is not needed. It is enough to declare __printf() in
the header file.

> +void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
>  {
> +	va_list args;
> +
> +	va_start(args, fmt);
> +
>  	if (panic_try_start())
> -		panic("%s", msg);
> +		vpanic(fmt, args);
>  
>  	if (panic_on_other_cpu())
>  		nmi_panic_self_stop(regs);
> +
> +	va_end(args);
>  }
>  EXPORT_SYMBOL(nmi_panic);

Otherwise, it looks good to me.

Best Regards,
Petr
