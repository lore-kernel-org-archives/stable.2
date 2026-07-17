Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C939237DE99
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324645; cv=none; b=HEs+scbuid7uicOznS9HTC0P5vUtF5A+eZVmdpBUQceRPvtSVZznuosKBXZcG0JAYBFPoZFoZpZ/hgZSMHt0ZOTN8rcfGK4sOcTK1iHhuOd9YK8ACu5gaXvIjeeQySS+SZ7wGe1jvl0ChTHOviUIsIQJhKu+3dRa3mIM+NfM+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324645; c=relaxed/simple;
	bh=KpS+kJJlBv35K/IrR+OBv+/9nhwQ3ebALGxL6RxvcYc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=T6y3ejxXQM//khnHcar0UShAElWE5cEqowIiNV41HWygPtw+yO5QjMAxVqEVLIFhSlRfzHLM915xQfPI7FrAa1TAOOmkVGjHvhKzVuWkf2Wq/7XmR1wRnVp7I18Q5HgkQFRh4iKfqih5v0ufUtmiyFeujurWCuWaRj4lM2ewpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HuIkArPX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HuIkArPX"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e85499ffbso392797485a.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784324642; x=1784929442; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UJW3E30PCmdsoWABkSpclpSp+OEAAqFq3cqhZKvUIpw=;
        b=HuIkArPX4+FEnp+kVpLyYKbxnNWk2qA4t4ngx476RuYUYg5hpT8zOCLEHWUw4KQBvq
         +ebIok+hfzEVPoVeYSx5+5kJajA7vnSP2QbNUXUqKygfdhDb5EcNmeAL+s2zPd6cn8XM
         +oYbitE6WXXbDrMe2VYtoPB7zr7a6gcnBkHU7hJjsuX5oVf7vwB6A2lYeJYaUlRznnp+
         kC+jV7Zh6EXpecz4FS/rzP3DZI6y0Fj5SSINo37b3c9ipXmKGjqW6U33AHLcxs7+aLAR
         jTcdw51C6iz1SQ+5uK1IGtB1O45XxP/YJ9FYeMGkmrn0sHnHytwPeDI2NZ15df33J1m/
         IY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784324642; x=1784929442;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UJW3E30PCmdsoWABkSpclpSp+OEAAqFq3cqhZKvUIpw=;
        b=B3jdsSToSsR2Rs182PslOjzxCBaKDsrni07bPfI3aE1uILhSV/hSPAbNPfm3Wzh60e
         ZBvfV33l8ZKA6aYzwCPa2uJ5mebT01j1J6sCjsVRizvB+3RYl1ggNZCWC6WJeYczOtHB
         e8OAigB/7v1vo+LPbKsz4LIH6VotNgVsg+G9C3tUCgl786Xnz7yHaFp9eJB0En4JX6a8
         +18r2+R8aZ7od6GCL+vzuo4ydIyUmAhXPeJTNDtnAU8Y8l74ClmCE9EcZimU8nFxuEA+
         CQDX+1nhFGP6deu++KeDXT7/+ml5KYiLEAst8XfEav76l0d/wmNxlkhBLt/dHFH0cNd+
         tdhw==
X-Forwarded-Encrypted: i=1; AHgh+RprA4W6uS0fXzQRnVPvjdWBdHu1Lh+dn8xhvRiQXbf5xpEEDT2F5+ipqvAUoUGtUE+oHMUnJJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuX0shatBOqxtYXWr75xK/2tYrQf8PpIGFUOV+f1KKGbb0qMs
	mHxUJ3o1bS/NU6r5XqmnQsNlzgbwNudecyncPKCx4BGcHgYG3N6mn79GV+Uw4dec0Q==
X-Gm-Gg: AfdE7cmD+GOihMjVlnbiyKTSpduF2fWqax+gv9WuslCz6NEOE7B8ixkGnOnU9qQwgok
	Tcje3TMGOAbukxIzTdy4qcjTNKfLYz6XNaHldn5kyPyRrb3yUhKEZ0kRUOvdiwRYOR1H2F5uk7L
	Hrflhfay0aB3Wz2+VGLrL2RKBXch6TExBwClbNeVVx8tMIcEToRTt4brPtGrJ1z4qbvUjRY/R5X
	Qq24XRqiWWxFjLaGDgLBdZk0IJZc5/+IAf85SLXlMw71FEE/hv0PgFP6oQkv5SrAdzH8EenDb3v
	7wRQ5yKWnE+/IYxYcYAmPEaWkNf0zw9NHpsMPYtind8TCQysF1vrb7nt1yfY19jx7PGvBDpnBRF
	wxcCo/Alj61NXPJaXlkw9s9rNC026UJBLJF8ikdrs6OdO4IHJO8yqEJ6DTVoP87ZLNwd9p4iPQ4
	WOHI7r7byvoPvChAaSHMvI9ueurQP/aIjEJ3M3S8X+1uzUcps=
X-Received: by 2002:a05:620a:3948:b0:92e:6864:b83 with SMTP id af79cd13be357-930b41f9a0emr496351085a.69.1784324642573;
        Fri, 17 Jul 2026 14:44:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545ed7esm250064285a.32.2026.07.17.14.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 14:44:01 -0700 (PDT)
Date: Fri, 17 Jul 2026 17:44:01 -0400
Message-ID: <1b04c65e7aca9259a405b926346214e3@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260717_1734/pstg-lib:20260717_1256/pstg-pwork:20260717_1734
From: Paul Moore <paul@paul-moore.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Eric Paris <eparis@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, stable@vger.kernel.org
Subject: Re: [PATCH] audit: fix potential integer overflow in  audit_log_n_string()
References: <20260715024635.25376-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260715024635.25376-1-zhanxusheng@xiaomi.com>

On Jul 14, 2026 Zhan Xusheng <zhanxusheng1024@gmail.com> wrote:
> 
> audit_log_n_string() computes new_len as "slen + 3" (enclosing quotes
> plus the NUL terminator) and stores it into an int, while slen is a
> size_t.  For a sufficiently large slen the addition can overflow and/or
> the result be truncated when assigned to the int new_len, so the
> "new_len > avail" check can be bypassed and the subsequent
> memcpy(ptr, string, slen) can write past the skb tail.
> 
> This is the same class of bug that was fixed for the hex sibling in
> commit 65dfde57d1e2 ("audit: fix potential integer overflow in
> audit_log_n_hex()"); both helpers are reached through
> audit_log_n_untrustedstring() with the same length source.
> 
> Make new_len a size_t and use check_add_overflow() to catch the
> overflow, mirroring the audit_log_n_hex() fix.  No functional change for
> the in-tree callers, which all pass bounded lengths.
> 
> Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  kernel/audit.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 562476937fa7..547ae0cebec9 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2120,7 +2120,8 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
>  void audit_log_n_string(struct audit_buffer *ab, const char *string,
>  			size_t slen)
>  {
> -	int avail, new_len;
> +	int avail;
> +	size_t new_len;
>  	unsigned char *ptr;
>  	struct sk_buff *skb;
>  
> @@ -2130,7 +2131,13 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
>  	BUG_ON(!ab->skb);
>  	skb = ab->skb;
>  	avail = skb_tailroom(skb);
> -	new_len = slen + 3;	/* enclosing quotes + null terminator */
> +
> +	/* enclosing quotes + null terminator */
> +	if (check_add_overflow(slen, (size_t)3, &new_len)) {

You shouldn't need the size_t cast for the '3' constant.

> +		audit_log_format(ab, "\"?\"");

There is no need for the additional quotes, see the related
audit_log_n_hex() fix you mentioned in the commit description:

 audit_log_format(ab, "?");

> +		return;
> +	}
> +
>  	if (new_len > avail) {
>  		avail = audit_expand(ab, new_len);
>  		if (!avail)
> -- 
> 2.43.0

--
paul-moore.com
