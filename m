Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793177505;
	b=toJuL1Z3XlXK01rt0y2afYh3lfoSpPrDhqGaNsQMQ1oqAQGsQ93LutsOXxMSVm2B64Dm
	 1wT7XHFdChRjCS5cvipseGGdNP+eUiBu3ng6841g7Y2vmBS8FcItSRO+aXgPqwc6oDmau
	 P+iyven4XfUv/CXAHbaXbyuGmAGOvL3cBynxOu9kyzU216nDtnqiJ1VNWLUrh4ElY/NCn
	 e9KHc1kLt8sT41e+7kWDs7IOkTQd7fTTXsWIjduACGDJinBOcpYSGqn2oVy62SY3V0P8D
	 RUdRoytCbzvtvZaTuAjZks/+AtYjmk5G7wHooFJqbdkzHI+Z8WkrfFyeZ2tmYFM2qDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1EeFooAMcisDZaa57XJjifs27WOCXklcXpVtOXVSG6s=;
	b=GXIMzJSGI+IWX76RFMLiymUnr8q2NFW+dHqIWo62iKHLsnhGzgkCSmX5Ww60yuu0nf9s
	 SO4dAtOohhQs7YQEDZfPVShxtD0bM+h82/RTzu7u/YkQI9M6iWzuDr09jrjDm8jenPqGw
	 2/7ozU7vc9Hn2aBzNjXHkc8fBqLDUNWja/ybVRl2jcaz0+mV8iX+NbAwEoyss7FvfK99O
	 ZQqNZLU9vb/pEpNmhPdgd4EThfnj4QyFX34lAc5qLEwj+uiyLbVt4fcC1m0lsT3v5m95+
	 MBG0dAMBiSZQlE7+FGn556154KIAlOgjmp4po0MZG0/02LlS10eKZhwRCWnxtkvWaeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZQP1Ay8w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62812606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62812606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZQP1Ay8w
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e812e2b31bso3714315ad.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 01:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177504; cv=none;
        d=google.com; s=arc-20260327;
        b=Gw5CS06JpsO+R/6WkT/7gEoK95s7XNqb9+Q1ctf6omY1kFtYKZzNNLT7Kq48cdQrVK
         9ikfDZ4js073GxvS2LYhd2xic1WIe/vA/T9KLA8ukBv4UnmqRgcZarNGT48RragqYwd5
         Er6GDm9pk3llDLSq/b2LNHroc2fDfZpUnifG8YaJNiTT6Lb2aCzwirWEzIwlm1iFj0xO
         zi8LxBJsaOYGz0mrnnbIhgzcL6hS73yTWAtwTGBUxHsq3vF/dtvqzxvAMXUAABugFxva
         m5sERqlR3cu+riEyWWnweDorAdBDEdOZQxHK5TlxIry15KGTVNl4swsPYCB3svXime7f
         b3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1EeFooAMcisDZaa57XJjifs27WOCXklcXpVtOXVSG6s=;
        fh=9dGfERAu+KxOyzX++Ta1TapFf/a/VzU578vzKgfJ6wM=;
        b=ZZTcapW6G15b5XMUqFAltPcADH+wonhJQ8pgl9WwzwEEhcrKNXrckpWQLxtxzDW5Wn
         iMjL4kmrs4nkrcV6J3GSeu/TRQ4a3tvqJcVCGmJ+EwG92d7R9NI2GFoKorTFGavUKB0J
         /A6lePQyILW6MKEYw9wTYp9WmaTTC7XrdaedcReTYxJZM6gTTGu6vtYkb6SwHGcMurCS
         h8lDArIFgznb54hlHrI2FkNH8At/S8g6M7EHXSNaqew1ZBq16DKF9hzbvmGQ1QAokidN
         m+4j8FNXps6yKQj7uQNp9WDRvUfvQ1NFmftJ/KprPxMdSdQweWSHxvlQH9wEWYJPyd6Z
         arhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793177504; x=1793782304; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1EeFooAMcisDZaa57XJjifs27WOCXklcXpVtOXVSG6s=;
        b=ZQP1Ay8wd6LeEZqlcy8Mzgpc1cJNvzlAcc9GY/nFpF5MJMCMiwbItrR7g8j5zdKbNB
         wuJbcNsp1LhPspb1Fu0Gn7zIVq7+3UwMcfqXzriyCRfYQfJfkNvM9R+qBq6YY4YfHEyQ
         +R4GAOtt1KZm6VjJWrUezRrss7HHXtxOD3OB8CY5XS/a1U1rQZ8hprmaJQ8ArM9z/u+3
         sQiQcUyvZoUefKgbj5nZkSIa9WQRX+ZKqcVhejOQZRpUiixmZD6lpNQHimMVl4iDyQfX
         zYIqS6PP6U+jBLjL7Eu3pKqMko7NbZRBZo0cMWD15/YCPzUSfiiUIb61XTd7pAmQ8yo9
         GBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793177504; x=1793782304;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1EeFooAMcisDZaa57XJjifs27WOCXklcXpVtOXVSG6s=;
        b=lgDqDv0t8NDkVRy9IQKhyPRuhkgcJ0cYtdXHd6CiiCh434KaodaVbr05Ou/K2eQGbt
         g0MjAGZGDfsQi0gGWqvvKiiEuN9/BwNaX/M9buPVyvsZO6S/gtBm8BuWM80ScmKBrD3Q
         9jfovK/GGPxgXU8qN+0e4zMefTpZVz8uwWlUQRflTFpvT4svuU4Cy4AWYKW9kHhdbQhG
         c/g3m7SzU50/gi+NLmeORL9sUsoK8SNl0yyYtpZNc/FwBPmbgvEatehdvM0fpxWMN6D/
         CJi2uKxH4biszN7mocgpVM0YDMl+DaQyiXkGkK9g5NGuHbYmfGEIESqxBmlOd+WwNJ0n
         k1Tg==
X-Forwarded-Encrypted: i=1; AKwUvByxcCwzWBEH9NjHn2w2wVBnEXoUvu6kv1NpebtEWJy1fVh3qN6c0FWVN9OqyzFNmNC5y9zRAfI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIh+XiJncU1C0IuL2ni5FSxyZa0QyBuOpWqTyF5s5YA96Z+lgto
	pI0CZm+uhlWezxuBZQrrJpQ+u+i6HV4u/7FZ0EH3b0abPHIDy7A0u8WfaImQdN8AVgPuGsWvnxq
	bJxtAgwypJo6a3LZ4kPADtKAP8wsBvOk=
X-Gm-Gg: AYBFou0ZFdskAfc2tIt/AeHJ4J0VE2vuH9vBTpACLAh8FDQ8rYG4l8pxAuGZj8B9Q/I
	Veva5ALRCWJszxJgIvTn4pO+98Ch78N+5DOXvrSFnnNkNHX0qh9aQtr05YqgcvCN54ZA5VOMm3A
	LNRbsPtiHaUg6M+IOKiusprIKYJR97ydOPWOaXj4iK/MorMRfI1jeDHSVnZQkKMyZ7Kq7Im6w7p
	X3BRAQtafnRZzh6yuSb083tF6Q5f0hmpfvZAT5uvbRNToyqFeUJtEJhZys5yUlsQDQjIVb93DzV
	igIFvQ7LWNv6l645dP01fwX9UezLPakLUjihMRMA6QbfxUfQGU07WlsDPRulNXURmSHAAzKYnYP
	6ZirNzluM1Q29Iz+jHoOBcXWQvueLs7eTfL3GUYs3uuMTuz0zLpkRhs/V
X-Received: by 2002:a17:902:d546:b0:2e8:486d:fa00 with SMTP id
 d9443c01a7336-2eb00374563mr16912315ad.29.1793177503597; Wed, 28 Oct 2026
 01:51:43 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-btrfs-fitrim-freezer-v1-1-0ad1d58aa94d@zliang.me>
In-Reply-To: <20261028-btrfs-fitrim-freezer-v1-1-0ad1d58aa94d@zliang.me>
From: Luca Stefani <luca.stefani.ge1@gmail.com>
Date: Wed, 28 Oct 2026 09:51:32 +0100
X-Gm-Features: AclHuK-W7tQ9BUgY6zXhq61ZHhZ-QvaVHjA4WXgAGEYQXLZpdA0nUbFDuHHyB6w
Message-ID: <CAO0HQ0UE5BtevPHHfV9mQo5HoqzxzDDjAkj9e=pD_0AaXmSYFQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not leak -ERESTARTSYS from FITRIM to userspace
To: zhiwei.liang@zliang.me
Cc: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, Qu Wenruo <wqu@suse.com>, 
	Filipe Manana <fdmanana@suse.com>, Robbie Ko <robbieko@synology.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 07:57, Zhiwei Liang via B4 Relay
<devnull+zhiwei.liang.zliang.me@kernel.org> wrote:
>
> From: Zhiwei Liang <zhiwei.liang@zliang.me>
>
> When a suspend starts during FITRIM, fstrim can fail with:
>
>   fstrim: /: FITRIM ioctl failed: Unknown error 512
>
> On a Fedora 44 laptop with kernel 7.2.7, 3 of the last 21 weekly
> fstrim.service runs were in progress when an automatic suspend started.
> All three failed this way and left the filesystem untrimmed.
>
> Since commit 69313850dce3 ("btrfs: add cancellation points to trim
> loops"), the trim loops return -ERESTARTSYS when
> btrfs_trim_interrupted() sees freezing(current), and FITRIM returns it
> to userspace. Since commit bfb670b9183b ("btrfs: handle user interrupt
> properly in btrfs_trim_fs()"), btrfs_trim_fs() returns it right away.
>
> -ERESTARTSYS is only valid while a signal is pending, because only the
> signal handling on syscall exit turns it into a restart. But
> freeze_processes() first sets pm_freezing, which makes freezing() true
> for every user task. Then it walks the task list and sends each task a
> fake signal. The trim loops check btrfs_trim_interrupted() after every
> extent. If a check falls in this window, the loop returns -ERESTARTSYS
> with no signal pending. Nothing restarts the syscall. On that laptop,
> with a few thousand threads, freezing user space took 2 to 5 ms in each
> of the three suspends above, and all three runs hit this window.
>
> Make btrfs_trim_interrupted() treat a freeze as an interruption only
> once the fake signal has arrived, i.e. when
> freezing(current) && signal_pending(current). freeze_processes() sends
> that signal in the same call. The trim loop stops at the next check
> after it, so suspend is not delayed.
Looking at how ext4 handles this scenario it seems to me they don't set
the error code to -ERESTARTSYS and (from a quick glance) return the
bytes discarded to the caller.
And like before they continue the discard (which will skip/fail again) until
there's nothing to be done.

I don't know what the intention of btrfs: handle user interrupt
properly in btrfs_trim_fs()
was, maybe we should just swallow the ERESTARTSYS case in those scenarios.
>
> The restarted syscall re-reads struct fstrim_range from user memory.
> When the device phase is interrupted, btrfs_trim_fs() has already stored
> the trimmed byte count in range->len, and btrfs_ioctl_fitrim() copies
> the struct back unconditionally. The restart is then asked to trim
> [start, start + trimmed) instead of the requested range, or fails with
> -EINVAL when nothing was counted yet. Skip the copy_to_user() for
> -ERESTARTSYS. In all other cases the partial count is still copied back.
>
> Tested in a VM with pm_test=freezer. Without the patch, 18 of 20 freezes
> during a trim leaked errno 512, and 10 of 10 restarts after a
> device-phase interruption failed with -EINVAL. With the patch, all 30
> runs restarted and trimmed the full amount.
>
> Fixes: 69313850dce3 ("btrfs: add cancellation points to trim loops")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Zhiwei Liang <zhiwei.liang@zliang.me>
> ---
>  fs/btrfs/free-space-cache.h | 3 ++-
>  fs/btrfs/ioctl.c            | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
> index e22443598b..cba2f5fd6b 100644
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -58,7 +58,8 @@ static inline bool btrfs_free_space_trimming_bitmap(
>
>  static inline bool btrfs_trim_interrupted(void)
>  {
> -       return fatal_signal_pending(current) || freezing(current);
> +       return fatal_signal_pending(current) ||
> +              (freezing(current) && signal_pending(current));
>  }
>
>  /*
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index ac070c745b..b02c59cbb0 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -529,6 +529,13 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
>         range.minlen = max(range.minlen, minlen);
>         ret = btrfs_trim_fs(fs_info, &range);
>
> +       /*
> +        * A restart re-reads the range from user space, so do not clobber it
> +        * with the partial len the rerun would otherwise take as its input.
> +        */
> +       if (ret == -ERESTARTSYS)
> +               return ret;
> +
>         if (copy_to_user(arg, &range, sizeof(range)))
>                 return -EFAULT;
>
>
> ---
> base-commit: e17e64baf63f7c85bec209ed73f14c1b2a7e39fb
> change-id: 20261028-btrfs-fitrim-freezer-d4cba16e7e13
>
> Best regards,
> --
> Zhiwei Liang <zhiwei.liang@zliang.me>
>
>
