Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793800735;
	b=pY2HH38cpUlMr3N33RiRbNP76QA8xspFQI7Eov+qh/fAN4mFDO59l1mcKC1USVGek+6A
	 SKMffYXUZoityfFk1XttXCnt7cff5rwp+RGNklHGePFCrlE8JpikDQCtGaPmUw16krn+X
	 PbvnDN0cBuB8UT71PFHtGEEqeer4uNHqFNaw+7JKi22hZor418szWzR8oXyhlxLuphCKQ
	 9x+YbH5CDFyfu7K5aOhY+k2jDVkznx2wQZj5+qPxDY+JNUy5QISzF4KnjnQCqE6UKg6g9
	 T219xPMgoJDJ9NXa07HcWZv0zSUV8ok22SKBgZ5hMON+c2jMWksxvJrgPDWynHGWPMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800735;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=o4EIHpxl57I6a94RuHg0e1sZQ5iF0hUORfBXfBn7tP4=;
	b=tg0ayZKDYdU1wtKvSpQqSmk5RP8uFb8XyuWI/mSMFInoX18uxSxc7WdfT5EPXy1qq34r
	 fw+lmJqrLM3F7HH6OGTQfyQlf/BNyUKrAaKSsXeCX3G5stJAcjZACqnBYjwPGL3YGyX8C
	 J7NeepM101FICaG88fRnTzUtZol69Udwpt46j6VZuGLEKT9XzrZmtxR1eu2tBLxSiAvru
	 12ojffRSoI+CLIMtnE4G/47HGcZdlXld27RNqM3c/fXLhp+2k6Gq6Ka3LZiRXm4p8fd7s
	 sB0DD4L1AelBER96TJ0OQy+99ZAC5rztOE0OWIeMC+Dmm05gyr/sXwO7gp5O9kiny+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=fail smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3B606D80A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A3B606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso893503a12.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 05:58:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793800733; cv=none;
        d=google.com; s=arc-20260327;
        b=geyPKzJXQEiJrjQ6yf5EHkkhYwhoHMSDGMDd0lNDeXjRzy5vV/Y+GAIj8h6a70aj9d
         E32uofCqhw1mTkG3AHtUCLx7w1xDEQdGy864hZIwG2yPsmO3Tfdhq2yWJwrRukaNzPdG
         8PbQF0m91hAWv5QEEAaEyKCp5Z7yiLf6qRJGqV9idXZhav+/nh95C7TZa4cNnyiqF3bk
         hSzkT0LI2+L2SziIPnh9mheRXx+yPyBSsPXz2qUlvOkDgWCbcmqe8d1uH3ZL5uA8E11z
         j2dD0h2oZ0bS5nf4T3oWY4uYbGEvlbcldkQXsoWIo0yiARNL4RLseI/qecnV5NzKgvxn
         KBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=o4EIHpxl57I6a94RuHg0e1sZQ5iF0hUORfBXfBn7tP4=;
        fh=b6h05p42ZqjKiJNDhU6ogjiKvoXPKIvENxxpw5GcRCY=;
        b=iDT3s9GPsHkOFpI+6cMI6j2HGZzbdFkIBUe1qDKjmQ11/jpunnOqFVN/HXCLlLp3cd
         HYGvXalIQg2X77WQLsbHAcZZEL78dDSNQf9/NKQcE0YSHC6jCk5LNg7nr04olxvewmj+
         NpXuhpBJdebtpom+vd5KLprzEdILc1wWBVZJAGaZ+y+fOZcxrUT96xf3GX5Kuz9TBYty
         m1HMhFf/0HW0l/9xpugoMxsEOq8zF7W2ASnOCOkHTeUi+Z4dhgccRKBcg4jfDzAr/Nwy
         CgD+0YV9QaTNfCzLVw6Xm3figkNDZH50JACLZutu4ugY1ES92usmrM5d64qNRm24FRLJ
         1pHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800733; x=1794405533;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o4EIHpxl57I6a94RuHg0e1sZQ5iF0hUORfBXfBn7tP4=;
        b=E6o5k6AePLBO1aFwfZsbJoLwUuktFbhntfePBcSl45Pu4TjeDjpYNI6bQ6YFcS06Wi
         557bfVBCcBP+zJFawIKowUKNUE8KXDvRToU0UT1txbI2zpJNRB1fk/7zbY4QpZCxQ5qm
         fu0dyOt7zsypu8w4MGpRni7N01VBwFayZgoPqyqOOTxXBFa23zpN+wnFSN0rWt/nbxkB
         HiSdan/SHr+vscN1bLdtk40nkdnQqjSgfwavj8/cHrw4ZL+cULBCi5wiwoHA0Xl6T7w6
         DCnSgWcaUApbE7uJxPc74MxpL1BDPE1DSWfVMcZqVb7DLSFQWylEAON1nd+NlRpTikMZ
         tJnw==
X-Forwarded-Encrypted: i=1; AKwUvBy4+t+gws7Zu5ePccuRUSGUmXNfQPzhlSRLfkvZVhWgYej8EMmjXJQ6yPVP6SKWeDvF9ApUKms=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wY89VLUljSW4JiqYPt6ddpr8dPWb9Pl+EeS0HzQMuVy4dAiVE
	9M2RIyApvbgHWzeHD7/+40xNqxZICBOKD8vsyMjWyvUCdY5UhtYw53HaTKCNNKqag8zAS0bYsnl
	UJt2AW+NrS4/BlQmZAkESVVYXI6Bwf1YH8bN5S3XeBg==
X-Gm-Gg: AYBFou2wLYFyKoifXy1W41U0MXsP8HF50wNXv6kOt4GSVJSRtTX2ad6RmZLWc3VsWLG
	VYGZmEpDRzod4zob5dN4eXJJ4383dp8hhlzZbx/IovQ5wXiiG+FG/3oHds+xnJp0HXEJw4ftUJv
	1uEz6nJwUOKuAlwQ52S484IQMCU5wEzC0wLfyUiOf8h6n1ARohhlJ865DJDPD5vh9oAdfd52GHv
	+MXR/Zxm+LGlM7Sznk5fEGvns1hEc6hGEBOWwRetRLrcI2Gdlhq9N+ExUerqdFBvQ2bhbTnDyof
	JnUof19eODr6i/3gnOSXDBmFs0CYVBYaZHNo/AqSBkmLXmcJlIZfbvXON3YCPKfUMge/Q70GhoG
	E+5E/fTzW0jW3cUS5r+UTAznVqc4GmSx5p2JO
X-Received: by 2002:a05:6402:10c4:b0:6b1:d439:5c5 with SMTP id
 4fb4d7f45d1cf-6b4d3374024mr8489250a12.3.1793800733137; Wed, 04 Nov 2026
 05:58:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020190319.884375-4-opensource@grische.xyz> <179279532482.3134.8732796861806998047@kernel.org>
In-Reply-To: <179279532482.3134.8732796861806998047@kernel.org>
From: opensource@grische.xyz
Date: Wed, 4 Nov 2026 14:58:25 +0100
X-Gm-Features: AclHuK_IvwAzwzvaVvW3vcX9pBmkxBHmo3ddDOqECYjDXhAMhYt-2sOn-aUE7ys
Message-ID: <CALsH2cwoB3P5Td3SgZ7ARTcGRLhCANSDU9dXake6ty1XAf38Tw@mail.gmail.com>
Subject: Re: [PATCH net 3/3] net: stmmac: dwmac1000: stop hardware from
 dropping checksum-error packets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, o.rempel@pengutronix.de, 
	stable@vger.kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, aaro.koskinen@nokia.com, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Does this work on dwmac1000 cores that use normal descriptors?

No, this only works on enhanced descriptors.

> Would it make sense to set DT only when enhanced descriptors are in use,
> or to make ndesc_get_rx_status() report csum_none for checksum errors?

v2 will set DT only with enhanced descriptors.
