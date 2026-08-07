Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B142377A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097924; cv=none; b=aQAFMMw6N1Pu5NzDnC3mNsQYFT9CiO2V1wpVdKDWt+qlx2qRy8wMgTgwn69ZZeIXLq+gx98LZsjNyCTWZdS3X7texkrjB5Vuq7O5L/DHvJA93Pa5RC/ptB3k7pT1CCPND40PZ4NGRjJA+W1GlL3QvCL2SZpLYjVtaMoju2TV8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097924; c=relaxed/simple;
	bh=swwNdyNOuG+rrh+9ckbxfLqbEyJWb9xoCLIj70Qh4Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwNu2yb90O88KwIm/ZZV/ajRiCZSv1SjiM3eUTrf956gaIJaQ/HE+Ot4KXkHG9vfZgb/xPu+EFsWznIn33ZKu0UgHExMticcMaqnDodXj/sCHJpye95E/5Ir1r6VjadW4+xnkupOabn0MwtxX9LBBrgO79AZBOayjuvxuXSPZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qs21Oy+C; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qs21Oy+C"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ce7d2adef4so48075295ad.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097920; x=1786702720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=26aOYNU8cqzDph/sVqTC2GyHiGPyVoWWt2+tiQQ8zSE=;
        b=qs21Oy+Cssj5h4Ya5X36B885jXv8pT6XjNwCv+kiEPcjjRu4HApoK7zuY+CiaOLUkQ
         Jh/j9aOB505xqkzGHDFOlXrtNTLb5O+61joDh2dO5AXcikV1dzvinHgU+hWmRgGv9Lqv
         C8shT8wbnpJJEbmKsGB7+iQhi419BYfz1d9PWjJqtPTY/2mzKKicAKkvnfWY3zHzEjnG
         uNANOKELlt70El/jfp5zaNaBG1Sg5Z79ZVcYzM8VJzL16bleYlTq//2NKOe2nmZu6H1v
         YN6OONaqlqiMvB6m5p8xSmFnFO6yx/TryUV1UsFAQgjsxdhJX+AGLeiyCqV4lnFxmovr
         uSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097920; x=1786702720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=26aOYNU8cqzDph/sVqTC2GyHiGPyVoWWt2+tiQQ8zSE=;
        b=UHqoS+Qdl9LhSzC2DJjKNzU2FjebXSnxy6tbYiz3KAKBUEnz1Wm0hWTUMdeQVZFjDP
         YmTzjsYRj15VAtPGQTsSs2yBamvVmOhOtYm2WOoRMnhJB0q8cdud2IxydkcS5X5DropB
         ah+nf0bzhLE26Shhp+3TuMeNVkeuvtr01dUNmsLndaH06bU2bJVACAvT1wIq5U7KkwdM
         ySS9aYX1IxZoZG1FdculkEQH2nHyBahvuFMi+fwReYgFlxEjEdRGg/KHaKRWQzPS36Yi
         2Kcl6gtbRJgLs9Kdgit4dx7VtkUqwYMqJnduqKk9/A29siQjPE+my7n+ApsaXDAe56Wt
         dPxA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4JyiEaOdEjHs3lz6tBvschs4aoDCjhNKhMvB7lnkc5IQ3bM7EY6piCeeQtoMj8tbfd6usBWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5tZPlFhV2HPLWBo5FBDZ5RReZdZTbM9sudK5lPMOyAyjnt4Gw
	kn4Gd5uHbvw1Z4rxxoUx8AFAn3furcpfTe5Svf5OyV18CDURCpojCYy/yVottQ==
X-Gm-Gg: AR+sD13DgpRBzWJuRCvqXcpUN+VP0zYe5VKkIWnyas+RQ6xjcbLUblCLm5YYrFaLZYM
	rsW+gfJAgAfD9SV2nVGP96i9SsoLLkp7ovIdMXZCtpmXXGSAILYHnLK5hVjm5rFM3i8JYTCsNTF
	zin8Unfkz7RcQOF8/XJdOwO/kHBQj3U/Fw1HWhIFu28AwfgG4034VVxNC8BSm02/5EzcGI3O35+
	4DskIN/1dlm9JgzWKvkW//tKthR5jnvVsEzekmR6wqvhvx4e9HXwX5yt76YtpM9ZW8qNHhHrMqZ
	qX5bmGAAOsSj6JSh/hNrf7kwqvdIOrvHtUVzW19h71BpVvO1H7pIN07WHSOVjxyXEjKtYjgxaXR
	dfes7LJFePKNouwCT1aQAxByu2yq7B/RYEp0Md+3kFiwJpPZZjgNwL29GcFYkUvdts/xmjKI4/D
	A3F2QiOYpypL2DVY0nZq5ln/8cKuPt5g/ii8W6i0S/C+ZLcA7Ux2FNuYhMI9kbgolQ302x4ZrMV
	0Wg
X-Received: by 2002:a05:6a21:50e:b0:3c3:8ead:6df0 with SMTP id adf61e73a8af0-3cbc0431dd0mr3861597637.28.1786097919540;
        Fri, 07 Aug 2026 03:18:39 -0700 (PDT)
Received: from Default ([2409:40f4:1008:2f0f:a99c:b93a:222f:dee9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199cf49sm5799159c88.3.2026.08.07.03.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:18:38 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: i@zenithal.me,
	jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	valentina.manea.m@gmail.com
Subject: [PATCH v2] usbip: usbip_host: fix null pointer dereference in
Date: Fri,  7 Aug 2026 15:48:22 +0530
Message-ID: <20260807101822.20922-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080734-carnage-pointless-9781@gregkh>
References: <2026080734-carnage-pointless-9781@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 07, 2026 at 08:00:31 +0200, Greg KH wrote:
>On Fri, Aug 07, 2026 at 10:07:59AM +0530, Jeffin Philip wrote:
>> rebind_store calls do_rebind which dereferences udev without
>> checking if it is NULL. If busid is registered using match_busid
>> but the device is never bound to the driver or it is never present
>> in the first place, it triggers a null pointer dereference when we
>> attempt to rebind the device. Fix this by checking explicitly for
>> udev first and returning -ENODEV if udev is NULL. Add usb_get_dev
>> in addition to the null check to get a reference to udev to prevent
>> udev from becoming NULL after the check. Drop the reference after
>> using it in do_rebind().
>> 
>> Reported-by: syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=af76b01c9a0f0ab60fb0
>> Fixes: 4bfb141bc013 ("usbip: usbip_host: fix to hold parent lock for device_attach() calls")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
>> ---
>> Changes in v2:
>>  - Addressed concerns raised by the maintainer in v1 discussion
>>    - Added usb_get_dev() to get a reference to udev preventing
>>      it from becoming null after the null check. Drop the reference
>>      after using it in do_rebind()
>> ---
>>  drivers/usb/usbip/stub_main.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
>> index 79110a69d697..c911626427dc 100644
>> --- a/drivers/usb/usbip/stub_main.c
>> +++ b/drivers/usb/usbip/stub_main.c
>> @@ -256,12 +256,21 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
>>  	if (!bid)
>>  		return -ENODEV;
>>  
>> +	if (!bid->udev) {
>> +		put_busid_priv(bid);
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* get a reference to udev to prevent it from becoming NULL */
>> +	usb_get_dev(bid->udev);
>
>So what happens if udev becomes NULL after checking it and before
>grabbing the reference?

I looked through the driver and could not find where udev becomes NULL after
checking and before getting the reference since we do both of those under
busid lock. There is a small window between releasing the lock and
do_rebind, is that what what you are referring to? If so or otherwise, 
could you please advise me on how to move forward in correcting this patch?

Thanks,
Jeffin.
