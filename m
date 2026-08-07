Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978742E8DEA
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092405; cv=none; b=JTh86pqVv8QGylial1iKQQ7gQCaE8vaSxDXQoPisRTzClRCCSIG4aAk9FcALOvPpp8PQ3jbUxVAeZPFn/WGu0//G8bc2aGq4GZvJA3IvbSG2piSiRf3mBbbziimwrdq42Q4WoOPNoFHFmjhm2k25zAXKk3ePtebRC6tiw2Ozumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092405; c=relaxed/simple;
	bh=YwNlK7A55qB8396L/ayxXzR2FuOJIAlbmtaKLe06wEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtCR++X5nP0UtoRzCblYzZf+DyvLOLs2E1ZD+CfTB/PTRc+0XXorKhvTKZ+QpO2TnPzSgPyYPrH50VMgRKwUbRAVIqE2MHal12JtO7FGA7OAHPhXgRNlPZHzZW0KmBUJ+U4lWFvJU6tKFhlMtzb+yksXqn46xPS1IiRwtnevt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTqQQnqs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTqQQnqs"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso2721110f8f.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786092402; x=1786697202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xUSIPfG/BB3jKwKy9WpPCVr/+aiChLfo3itvMt00IKg=;
        b=iTqQQnqssJBaQhrmuBNttvYiA4M7bhMTfEOsYQ7juTuyPADDg/9Z3w1sca+gafFPzw
         d4Q7pc9FKVOLjo48gRxQZ6Ix4XZ1hYXy/tyecrWnDj6d7dgzSi9YpnWj78Va1rIeG3B6
         gDQKsUc0Xn4+JGmlu1lGqNs41wE1QzLYamCyE1GXtmQSGYhsK78YNudmKeEBBl1NjuLI
         GrzmOWpC75tXFivUFzaZblMDgEdQKg553ABfI8/j6es8YP/X0Tbb6AONRPQKyvg9i7iX
         qfvzCO9vMmNB5+eb9cN1xqjjJW8W2CDhHGQXuLQih8FL6sgYskFrxtuwS+ZXP3bC4ec6
         qx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786092402; x=1786697202;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xUSIPfG/BB3jKwKy9WpPCVr/+aiChLfo3itvMt00IKg=;
        b=XxAxl+8kIcb1PjnoeLsWbhC+4iMzHsris3T/YVXjCfE07vvyhffaf6INp+jhnGEfUk
         1nm9I36ElTCh196YApDDXXc9Zn+lMKbdB6O4tPO/Cn4Bxw///DT/SB/3w0QykQQ+wvJx
         i1VIFdpPU9cG2R2fr0DYVLDms0g//ZfFinqoBgHibgcz+G9FQ8wyoPY+0HRn+GLC4xSQ
         Op9fueP0NwRiHYsire2JsNOmGeS4uPg+C3tURZeSR/X/nXeYx/qbmUXwwvf36knXFgAg
         ldjU3yKIhkU1egWaC9n1G2wsPpuvOnDhqAcbxK4mdxjKVZ+/D55dW/Y2L9bYWjUeMph5
         3uqw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/RfU3YuCFfUs3TrSBTgtLe4ZgEqlOvOS+QH+0T7CFUAV1l7YllNwbLib4B/7LNoN+2vbZiEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXqLOLjgQ4FLeT78gBOo6MM762Y0iI2FQ7OHsMTwXTyoT5ypo
	L3IQ61quEfHIHMBs70Pvn64HH07lbBN5KkCDu6y0u1Eq2qcJhlITsmxB
X-Gm-Gg: AR+sD10IiemqQi0rY5N2tqev/FdZGD70K0ZBcOkXrGHy6HAd2P16Wlnyn2BdZb0sXr+
	M9wRJGJgjGpx8pOxONw6a+MrPQcQw9MclgOZtZCKj5UEsLRa5WmruGv+EURSyu/lY+cMC88dLWG
	VHhSCe4PJyFGLysPnzUVPSkHwoDcrfFxU5nmZ1RHXdypHE6EcYTq8tDLFEFfAvVf7oVlixq9fjW
	MjEOY9LnxtOg2KCXKfo/LEZg0d/vaERgb5Oz/vaBoMla1pJQSqb8+NlYu1gAkBm0rUxLub49qap
	KIa+xkMbcKPgXVLRoepj1TBTzKyWTEl2N3G5IlBrgNr11Whg/QzkK1gfxePEyd5FsglZ/RUHKBx
	dfsvcg2Hk1XkjQlYagA6Y4LAHzTZ0wPqZmYAD+3uQiFngYiglLi2mSZhOhslX8ku3GoC6Vr3gA6
	L9CRREMo9i4XHb/A7tgMQ1gs7b2UIpiToke1DQYQ+B1QkP2PJXgVLQoy5FnjCefntLi3cBwK+dC
	oVrRQ3IS21UM4FHIlB+ZWD+S70ToqtA7C5ncQJ7WusdnU9D9WpeWa7df4z8BsQHWA==
X-Received: by 2002:a05:6000:613:b0:47f:9176:da23 with SMTP id ffacd0b85a97d-47fec48270fmr31695999f8f.0.1786092401641;
        Fri, 07 Aug 2026 01:46:41 -0700 (PDT)
Received: from [192.168.178.24] (cgn-195-14-217-60.nc.de. [195.14.217.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506desm3865582f8f.10.2026.08.07.01.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 01:46:41 -0700 (PDT)
Message-ID: <576fd334-3482-4ada-9b35-2e67a024e306@gmail.com>
Date: Fri, 7 Aug 2026 10:46:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: dw2102: fix OOB read on firmware size not a
 multiple of 64
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Igor M Liplianin <liplianin@me.by>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+f408eac9faa61d5a1927@syzkaller.appspotmail.com
References: <20260806-dvb-v1-1-a750f8e5b2ea@gmail.com>
Content-Language: en-US
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
In-Reply-To: <20260806-dvb-v1-1-a750f8e5b2ea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/6/26 7:47 PM, Vasileios Almpanis wrote:
> dw2102_load_firmware() copies the firmware into a buffer of exactly
> fw->size bytes, then walks it in 0x40-byte steps while always passing
> 0x40 as the transfer length. When fw->size is not a multiple of 64 the
> last chunk reads past the end of the allocation producing the following
> splat:
>
>    dvb-usb: downloading firmware from file 'dvb-usb-dw3101.fw'
>    dw2102: start downloading DW210X firmware
>    ==================================================================
>    BUG: KASAN: slab-out-of-bounds in dw210x_op_rw+0xb6/0x180 drivers/media/usb/dvb-usb/dw2102.c:102
>    Read of size 64 at addr ffff88802bcf2ba0 by task kworker/1:2/803
>    Call Trace:
>     <TASK>
>     kasan_report+0x117/0x150 mm/kasan/report.c:595
>     check_region_inline mm/kasan/generic.c:-1 [inline]
>     kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
>     __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
>     dw210x_op_rw+0xb6/0x180 drivers/media/usb/dvb-usb/dw2102.c:102
>     dw2102_load_firmware+0x2b4/0x970 drivers/media/usb/dvb-usb/dw2102.c:1906
>
> Fix this by clamping the last chunk to the remaining bytes;
I sent this patch to syzbot for testing and it reported success.
https://syzkaller.appspot.com/bug?extid=f408eac9faa61d5a1927

Tested-by: syzbot+f408eac9faa61d5a1927@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+f408eac9faa61d5a1927@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f408eac9faa61d5a1927
> Fixes: 7fd4828f6cc5 ("V4L/DVB (8421): Adds support for Dvbworld DVB-S 2102 USB card")
> Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
> ---
>   drivers/media/usb/dvb-usb/dw2102.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
> index 4fecf2f965e9..4e26e1776977 100644
> --- a/drivers/media/usb/dvb-usb/dw2102.c
> +++ b/drivers/media/usb/dvb-usb/dw2102.c
> @@ -1902,9 +1902,11 @@ static int dw2102_load_firmware(struct usb_device *dev,
>   	if (p) {
>   		memcpy(p, fw->data, fw->size);
>   		for (i = 0; i < fw->size; i += 0x40) {
> +			int len = min_t(size_t, fw->size - i, 0x40);
> +
>   			b = (u8 *)p + i;
> -			if (dw210x_op_rw(dev, 0xa0, i, 0, b, 0x40,
> -					 DW210X_WRITE_MSG) != 0x40) {
> +			if (dw210x_op_rw(dev, 0xa0, i, 0, b, len,
> +					 DW210X_WRITE_MSG) != len) {
>   				err("error while transferring firmware");
>   				ret = -EINVAL;
>   				break;
>
> ---
> base-commit: fcaeecb8b0cd44f77d03b28de0671258d4db18f8
> change-id: 20260806-dvb-307714ff6225
>
> Best regards,
> --
> Vasileios Almpanis <vasilisalmpanis@gmail.com>
>
