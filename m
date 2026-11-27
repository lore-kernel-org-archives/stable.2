Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745669;
	b=aj5WJ9kB8GqevZ5ygsTlAtWSZLwRMLP8u/eDskEuDP3hqgzbvoZLcmdDPQC5ShJerxCN
	 C71nwf8fZr0YI0Af8COwbxCFBhHoT1UvjD3WyymCY7+O6L8fGCCcRkLsKPwMBGMvQgeBs
	 OZ339z1+IjLoO/2nLK39AkMSA8MtjzmeuB8/oeZsEovYxC8J0e727UNEQsB03y5nOoqx3
	 bywzewFBicyuNeL0385aLFmjqLMKHsgAzPqmKxvPxDRYkVznvs32o2clGvFvCzuI4Lkde
	 tdvaTepDVfogINtXWBWC8J+IQGmLbSFbICy1MEOKywoe8lwFjE5fCKw7QVJ+qdEWVEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4UeH+SqQT+FD9wlg8cp1/QgsPN9k+lyc/4UIeCKdJoE=;
	b=TciDHcGikrwYuwz6UNhm3rOktF/x9OiNMgJEUSCdqs6o/oTzZICSuZ7v/ekK44q1Sh5J
	 9yNfkymCiWQ40oKbhBpG7Illj+Ebo4KHuJf6NgimE+7KMjUF7AkNItSDr3lTBVWjDsg51
	 bg8nxrpqu2B0QnQ/9cwZiFG2Q9ZVQTZLgjA6Ceu8kavXvL6VTKO+THm48D3+T6mkTxsXH
	 WoTBlLHxfGnIUO5PGGh3OApAT/5iwK7nLC7DQZQDxlM/ej8MlAyT7Xaj+oHj25eRyfWUD
	 EC+e6DtpQPn3OrNhYoHSgi/pLkuJk0iCaPXBlsRa9ChrSy1Vp+95zOQ/W3OtxCFW4PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pZt1UIIs;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE4606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5FE4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pZt1UIIs
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so3717837b3a.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 18:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795745668; x=1796350468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4UeH+SqQT+FD9wlg8cp1/QgsPN9k+lyc/4UIeCKdJoE=;
        b=pZt1UIIs3XyYpJfZbWph3GHoe/PfYxb6o6lRdu4jNphswYo6syX1siGfHrMdOPpNqx
         BaBsqZF1oO0iQHN9aj0KFlV9PxJkvxHuqoBViJD2Q2UJ5xH0ckszCX4OYQ5E3uiW2OzU
         Hk/wcPH7GYUrfVeYtCR/8ueWiTy2P3bypN5y+uDs8WAfjuLpodUC9YPhk0mnXDcF8lug
         5BpFz81C687p8k9ah3QrtTmcHquTBGemjEUg3j+AnxYWKuybVjnJ+TcqIb8LFCfp87Zm
         f+1Atxb5he18hwX2gAKSg8sxV9ykuhWC9W7hkcEYLMT5JphtKFL4LKETGk3rKn0IF7qb
         gIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795745668; x=1796350468;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UeH+SqQT+FD9wlg8cp1/QgsPN9k+lyc/4UIeCKdJoE=;
        b=uex8NNBY+7YBrfFdQ7BAfIFfZy8iPbQuX+Z64h1nHJZ2WshlvVEpAlLgWuntVRzSxm
         mBGLS9o95pPUu7VRQwokZlp0P9hp6n9usw2TMDLLXxHgR4HI+7nv8WtYZrovFmEXRsgp
         CEKC0cVBE7ejDOQQE2B6O6OE6Lq221ayC1vIqqfz+AvMRYTaXqOMIVvnXNF7FoppEu9X
         yKriFeDnVqLwVyRPycBefthKvuoJCGDqYE095zQs9Ge4LnRDqK90kX6cSIeeeg3cTs87
         VNo3awHdNBCvZBeOzVXdxGzCRgZHRdGgn7i55+2WyX6LWXzv1ZLsuVZrSBmJ7GSPseBj
         f5xA==
X-Forwarded-Encrypted: i=1; AL+hErFTv+QWZqoUo/GlwPUH0kizIxK/CvY1O4uLwvX7kgocrr4ETCd0lq5B47GD5GT9pb2DiTPPabA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hLtPd9fztJCGxGhHSiYshyV4Z08H8ymWrni0v1LNTOt9tGTAA
	qRmekGx1ozn3aFc2kJ0uBpvtw0PCp2t1DWWB2y+wKgh/DuPr9C5ZOkra
X-Gm-Gg: AZFdTZegFwD2YSldWAAisi8mS5Ky3E10y5ByNq4y2yY9jZvJj6q6yxKuOB0yFR1kHCN
	9QpDCunilnr2YYbgjhKndtGaGj606YWmGjuHPCoOo+ndfCIIrmvwBe+ZW16zeR+GLUoWPT04D5q
	Tkx3VjDa1Ji7KP1/Jjiyr3gDiZvAr849ijIPkkRNnhUAz2C1jpsbzjqnnzzzcVCQDZJDd99rJjz
	nxwUtHgzCotu6lZbRFmbjPvsVNKXDmZQ1KX2159GkdWy2e+WNUOzv3qwrwHO4GwjkAnO34MzNsF
	3uNmDRu+7akrFkL0mSuO0vajNslQV36IwS3h4wUt/sfDZcmq40PLwHhyrnU9eAj1nAfmfGAXzrs
	fYjXDOKazXHsJfe7y1l3dQ0tg/MnpbGW0QHwksTJ/Ns2dtFSbJeCQXjg7X7ixTIGtS9uGMZCBUs
	7OaudMv7lVC6qhZfev9qwRkxxbNu7swP3+/7TXKykjDUHJmvHKlHTSxZJa350jhRMGKh4z7ep+7
	jN2L4Kiw++nfTMNOa58kAdtO22Lgr5lfEJ8iRfplA/5gtGPPgm7qkQjcC1Un9lboAdv9kMt4D2P
	yTZeipFa/oOkizJystw=
X-Received: by 2002:a05:6a21:4cc7:b0:3eb:3952:d703 with SMTP id adf61e73a8af0-4014d5625d8mr22775673637.39.1795745668234;
        Thu, 26 Nov 2026 18:14:28 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285ccf4sm11158830b3a.12.2026.11.26.18.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:14:27 -0800 (PST)
Date: Fri, 27 Nov 2026 11:14:25 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: linkinjeon@kernel.org, ernest.borowski.git@proton.me,
	liubaolin12138@163.com, ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v11] ntfs: trim the sizes after a short write
Message-ID: <awjnga4nQqW-5TOM@hyunchul-PC02>
References: <20261126015731.3254689-1-zhanxusheng1024@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261126015731.3254689-1-zhanxusheng1024@gmail.com>

> -	if (ret < 0 && ret != -EIOCBQUEUED) {
> +	/*
> +	 * Both sizes were moved to end before the copy, so a short write,
> +	 * like a failed one, must take back what it did not write.
> +	 */
> +	if (ret < count && ret != -EIOCBQUEUED) {

The rollback code is quite long. Could you extract it into a seperate
fucntion?

-- 
Thanks,
Hyunchul
