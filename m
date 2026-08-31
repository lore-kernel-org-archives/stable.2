Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57BB3D6CD8
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165491; cv=none; b=PjwnVCd9hz8nZs5qJ4fIhfLJJr+/XQLcZFasvDypEXSOtwJMShd8nFj6cbZIY6yXePnuTmht/OP7OAJORgLoLVFxfV9orWwH3+s6avs4dPbedWLtqP1G0YnqDSt3Ty/gcDTSSolstXd6ExuGKnlIceKR745qG5Wg3jNe7HTtsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165491; c=relaxed/simple;
	bh=WLtm+GBjS4mENbZdWq6ft2W9jH1OWPirkpQ5szhajHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGYxGZEMOZ8NytCqDrM8sj+Qzu5/Ap/r1agRm9TA6n3XMmt80PiJbvIc4L/zFVymcwB78Op68AJ1ysRUqNpYtEpIcPxqf9oJMfcgRPY2HBnDh+40eaPFCI2c/adJpFS4PqCfKSYr3SVARCg6zBdkbuauqtF9xOTIGe/LEp6HbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtcOLTG/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtcOLTG/"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so3326996a12.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788165485; x=1788770285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wvmBjNWujEmlSCyP5EP6vmyuBGO/nrT24KCWQT1TNSQ=;
        b=AtcOLTG/e8e8yduYS9tgCC1O5Dqgq0qNkM9FL6xjE+z6VAdoOOHzBkQvXfy536lN4H
         KlOpYy8g+kAF5aMzcCYu3ATuVbOOi95u3G9MccHKVVsLEMjXdLYt3C8LpebdjTYCT0sB
         lIgaw5TAPQ0JMhrtLE7VDI5UYHqT/VMC7U2Tt813tnxF2itGXWMQ0WU8V+r12UaAG88S
         Y3NvcOXzlssbXOmpeKQydrDGPpd1oghGf+ZbkLuF5HBS0v/n9RB4dPNnybWQdYjD7Nkh
         JrMc0VzVShlD5oZw5zi5YbJj6VPCstqab7kGYXLhCSkP+RGbmURurLP7EDKNBEkFVJhF
         WTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788165485; x=1788770285;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wvmBjNWujEmlSCyP5EP6vmyuBGO/nrT24KCWQT1TNSQ=;
        b=gTtLKcNn7yvnClo7NeKULaYtjHbfLtIAN9Kfqx8Y+ACVxJwPY7JJxCI1y0XaZcswI9
         v/nWvVm8B4xf0XxFaexIJT6SA9Je+k3WnC6iJ2zEMy/Drt22aTj0DtzK5UTtsijhs0Fj
         GuWcYD4vdMlqukaUB4XUwWvitAE+mmmLCMCojQUF5rc96RIeH8galhJ1BjmnawyD/pIK
         MyyKJKRyKV5p7lTvniWdAjD6EUFXWldUYlCqw2BvXm+vPm1aJVPy6HEVwSXJNKrOtffu
         M9Ze2aCnu8s4pFckqbz2OGGOa0qLngQQrbXox+6q7vvuyLwkaNLRxJge3X1trI6Xmemt
         2qvg==
X-Forwarded-Encrypted: i=1; AKwUvBwZzgG6sY/ngEbwLyjk9O22+D/8si9GLrZIqw1hUdxwWq4QvwLN+Z5kCy4M6jPa03DpohtL23Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nNRZfVv0I5l9n98EjJJWuvOMR34XnCLhbwX855N6EQPIW1A177
	cxyiyNAN0g8tEdA40ne7GuoKjsuFjYiCmafpbiKSP87IY2u8ByXwa4Id
X-Gm-Gg: AYBFou2bneW19r3U8bZ1lCzjeg7nb3Axzk8CJK0EmYo1Qry5R4jNgdFwyUIEqn33AoH
	yUyPoIcOiYgOU2lpPhcIUhqGM5UHfwfi+z/PEyfKFgmlxHA1VKev9760z2Lv6tAk7iCSewaiRY1
	YAfslIYmSBT5TXTMv+F4vijEKd89MumU30GQagfx3r/VkWvMUj7ypfo8ESaj8ffq313EgJSmbQw
	c45SBRL2T+WYnDk9AIfd5Iwv9f37uqntFjhS5z5U8Z/LUwH10RRb9zsoyRfH5RP71XMFP/XcZQs
	OK4hcpQ1xIcYc1ZpnInjCD6Ial0lyN586l2WhmOnuIuuEZ6rVzqS98GLbd+8E54LcWQoqjc43BI
	4JcZ+3meRq/J+PBhuKdpTjiI1VfbBLXuHORPXli3AJCsK4X800AFKH+SD/1Ie0oCMNmlbURyq2+
	+wiRp8K/d4/V7u3xYlxK52P9hB8l/vYBTN0WexF2JMdrGriShPr0lOwZX5OoIwNSSmFC5sdMSE/
	Q7TqBv6XxV48kJSK+E=
X-Received: by 2002:a17:90b:388a:b0:398:ceef:edde with SMTP id 98e67ed59e1d1-398da8cf414mr5021997a91.15.1788165484692;
        Mon, 31 Aug 2026 01:38:04 -0700 (PDT)
Received: from [10.125.192.112] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d7853da8sm5066022a91.4.2026.08.31.01.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 01:38:04 -0700 (PDT)
Message-ID: <c961850c-09d0-3366-73e0-1932c1dc00e5@gmail.com>
Date: Mon, 31 Aug 2026 16:37:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] zram: fix idle age_sec underflow in idle_store()
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, minchan@kernel.org, axboe@kernel.dk,
 bgeffon@google.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20260828083149.45760-1-jiahao.kernel@gmail.com>
 <20260828102446.3eb7f3dc779753b831e33fe6@linux-foundation.org>
 <apT-ocFYDmU6iC-j@google.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <apT-ocFYDmU6iC-j@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/8/31 12:15, Sergey Senozhatsky wrote:
> On (26/08/28 10:24), Andrew Morton wrote:
>> On Fri, 28 Aug 2026 16:31:49 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:
> [..]
>>
>> Thanks.  Sashiko asked a couple of questions about this change:
>> 	https://sashiko.dev/#/patchset/20260828083149.45760-1-jiahao.kernel@gmail.com
> 
> 
>> Does this early return prevent marking valid boot-time pages as idle?
>> When a page is accessed during the first second of system boot, its ac_time
>> would be 0.
> 
> There is no possibility for zram to hold pages during first second of
> system boot, regardless of whether zram was configured as a swap device
> or as a block device (mount-ed with real filesystem).
> 
> 
>> Can the early return above bypass this zram device initialization check?
> 
> We already do that, e.g. when kstrtouint(buf, 0, &age_sec) fails.  Apart
> from that, that's not how one checks if device was initialized.  We may
> want to consolidate those checks, just for symmetry.

Agreed on both points -- the early return is not a new "bypass", and
the write() return value was never a way to probe init state.

How about moving the init_done() check to the top, so all the early
returns sit behind the same device-state check?

static ssize_t idle_store(...)
{
    struct zram *zram = dev_to_zram(dev);
    time64_t cutoff = 0;

    guard(rwsem_read)(&zram->dev_lock);
    if (!init_done(zram))
            return -EINVAL;

    if (!sysfs_streq(buf, "all")) {
            ...
    }

    mark_idle(zram, cutoff);
    return len;
}

The read lock then also covers the parsing, but that is non-sleeping
and its cost is negligible.

Thanks,
Hao
