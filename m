Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C212110E;
	Sun, 28 Jun 2026 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782607665; cv=none; b=A/3HecQsmXglM2U3YQO+NCmmg3nInAmAgdfNDuGPduPrtswfRzHa3xHjuwlBxTuINEyEG+sDnkHJy6+vb/lDioE5ZOznc6DuZLLuNJ2TzGpLcQGSc/OXbye+OD/b24nMDkdGoLGvYef2Zi3YXm+GH32FhrXQsFyLCeiuL84uFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782607665; c=relaxed/simple;
	bh=NZ6j1BGDC9khMPyNVssQOx57nEoS2+yQQkNDQcqJqRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFH0O367FBKRbunr4O1qHG6ZWZjBYePrNb8jmmz1cJDHgZV9xwfxcy+QDL0y9UXbs/dFUb09IYicsHXNc5sb8yNNEdt7UNNVVj2KIWqMNGGFoWyYo4yWydfz12IYWcxGi1vv/Ud0XlrCJt627cVciEEI11w27ynSz3zBqZpvxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=nGQHXzZ5; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="nGQHXzZ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1782607663; bh=NZ6j1BGDC9khMPyNVssQOx57nEoS2+yQQkNDQcqJqRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nGQHXzZ5z1lH9Yebemdo2dz69YvC6Dfgg+avB43BPjrAQaZbGvE10J6tZkECtNeki
	 j/8kfFWWBbcmb4YjHpyRMQU8B3Ki3zhmqj6D67Yv+9RxywZQpv9SUgy+Yn+n/GXBvl
	 SYIC+R57ELXlw7TQZ6ioQeAkxz26EQuzA8eOQa5MTTv6PU0H1xIFdqcf1OlW/JNbgU
	 qT/G9yUU6bRiL/yVTAvFRvHQyXBRok6nlOFb6J3LUG2i/tR9vhF5v7vZ42IelHimNC
	 2aGIPBoELTp/WStn77mx+AW/mDzAGgud77qzKymrPS0hXnAYqESMIJTBKams/EV4zn
	 qikWfxC8N4sjA==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id A81A6132022;
	Sat, 27 Jun 2026 17:47:42 -0700 (PDT)
Message-ID: <612b5987-1bc6-4b42-bfba-9c72ee5d51dc@endrift.com>
Date: Sat, 27 Jun 2026 17:47:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: steam: reject short serial number reports
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
References: <20260628004106.26920-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
Autocrypt: addr=vi@endrift.com; keydata=
 xsBNBFtJAmYBCADmRIN9O/aBbYc93lUMvG2hPip++otLit+65EwNHB1y9BmbVr0Q8Tz7rbAM
 K2mB0EiA4Z3DesoLIOzlJq0E4fgDsAi8ok/i7aTx35d0Qeab95GEdkCMcL98xNJE0agq+KYk
 pnvFlhdyC23K32KdOijsUqqbd86GgxRZmuf/Yf932KxKAj+n0aFBw5y6i0ep7WQBF6ytpqah
 Uzy04D//smiTr6rrXg+C09MX0XZ2Fvcv3gmimnoV6C/ZCO1Zecqyhrs0YFfdIhFEBp2ItYim
 MoeU4g6y726gyRO/+wwzZkryJMU8hHootzW1gUylZeELSwx8uIJSHFiLE7AK+M5soPtDABEB
 AAHNG1ZpY2tpIFBmYXUgPHZpQGVuZHJpZnQuY29tPsLAjgQTAQoAOBYhBNj+0QMp9OPSosB4
 6X72E7X7Nb0rBQJbSQJmAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH72E7X7Nb0r
 WIcH/0GnIOkmAyy2UlgS/VKi193ZRWYJjBfUncIBf57gLt1KYY0PvUoR9MVvkLqcx8vaCxWh
 bVSqzxT6WU1ECp/URdQV2W4IGB6W4B8rT3VGw0QzbVVQRmt6vReEMFVL+vBfgHKTRBItiy7x
 Bd+JZDusiyrrGok9TqqkBYlZPWE29ajiOAe05N1UhuRq7y8w/bOkzFD36ohMtfqV4hByWV+q
 d0LujqgZm1AkM1FqpJ4j8h1Gox5rpmWfaHJmBQ8HcKqQfwACQCvDNHS2vlTXJYfxlh+mVerL
 YKZgWnyvqx4pLKqJOXQKssIaDjnDfTu6bQgXvhaKb1+piBUYuoe9/+3E15TOwE0EW0kCZgEI
 AL/KzT+NR1/LbJ7Kuv3gAHFp+S7cfyyPSamN6i6/X135vNSawG7g81iWUweAW6YahFA2haqw
 t+8/Bm9Dzc8rF6RHCElK1GoHiF4SIYQxjqPo2wwqvTad9FblWTfaYRKfVDvNz2Rz4i681JrR
 8gizvzJPX+gocH7FMzPwb1DAwL2kKA5wilgAGSv8nZqeG55hNt2t/XiT6Yd97DJv86D24UUP
 BetLTq2jUWtX+omt+JhF3QzMjnyGQYKHNXUB/ipBxNSkwnDrWg/f1EjDtNzuOHManJDC9Bqi
 qhi1abiTNlmmewI5iLEnnxzfSKS5HO9nCC1szl229DHwIMH7jA+G+z0AEQEAAcLAdgQYAQoA
 IBYhBNj+0QMp9OPSosB46X72E7X7Nb0rBQJbSQJmAhsMAAoJEH72E7X7Nb0roioIAM0oDKEU
 QH7Og4+AXm35uklIiCX6cFQPgDVlQn7M/QFLnEhhCfPTt8PkIIN4dLgs4lIJxExpgQWgOLUX
 h+ZLLupzZXoysAXfdwNLf/RqRed/zTZbUjssy4D7yeNIJThzU32kDy0Hx3pMNM/Hd9yaXmHL
 LDkfwcyQuqA9+eeOogkDC8inLNLfYQ8JtVQZuWppNcbOZkBxfMVAmPHg6C9fe2biQFojoLPe
 4nQheprKfBp5QsY2cIjP8kaWPpfJEJ5i2aNgtrfebEzjYoWWLkK78Lo8qABdxkVhH6rhAlw2
 rVf41cHNCfHF7ddvOb9IItWacXxYn7ql+dI/Se3+ISWDboQ=
In-Reply-To: <20260628004106.26920-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yousef,

On 6/27/26 5:41 PM, Yousef Alhouseen wrote:
> steam_recv_report() may return a short positive response and copies
> only the bytes actually received. steam_get_serial() nevertheless reads
> the full three-byte header and trusts its length without checking that
> the serial payload was returned.
> 
> A malformed USB device can therefore make the driver read uninitialized
> stack bytes. With a complete-looking short header, those bytes can also
> be copied into steam->serial_no and printed.
> 
> Account for the stripped report ID in the return value and reject replies
> that do not contain both the header and its declared payload.
> 
> Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
> Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=75f3f9bff8c510602d36
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/hid/hid-steam.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 197126d6e081..8c8bfb10e8b8 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -454,11 +454,20 @@ static int steam_get_serial(struct steam_device *steam)
>  	ret = steam_recv_report(steam, reply, sizeof(reply));
>  	if (ret < 0)
>  		goto out;
> +	/* hid_hw_raw_request() counts the stripped report ID byte. */
> +	if (ret < 4) {
> +		ret = -EIO;
> +		goto out;
> +	}
>  	if (reply[0] != ID_GET_STRING_ATTRIBUTE || reply[1] < 1 ||
>  	    reply[1] > sizeof(steam->serial_no) || reply[2] != ATTRIB_STR_UNIT_SERIAL) {
>  		ret = -EIO;
>  		goto out;
>  	}
> +	if (ret - 1 < 3 + reply[1]) {
> +		ret = -EIO;
> +		goto out;
> +	}
>  	reply[3 + STEAM_SERIAL_LEN] = 0;
>  	strscpy(steam->serial_no, reply + 3, reply[1]);
>  out:

I already have locally a patch that fixes this as part of my pending Steam Controller 2 support. However, it chooses to fix it in a different way that would affect all uses of steam_recv_report instead of per-callsite (with only one callsite fixed). I am hoping to get this patchset submitted soon, once more widescale testing is done, but if you want in the meantime I can pull out that single fix and submit it separately; it's a bit more sprawling and involves adding a new function for combined send/recv.

Vicki
