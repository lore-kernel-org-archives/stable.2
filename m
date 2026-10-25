Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792944626;
	b=t9Yz0T0mwKw9rEMGiGygcizDrWbvKA/8nuxo8tKKiOw4ZObZUPX6cfSuMeVqBsxkgdkS
	 dVUCPuUn+g0Ks6q5jkBgAi2UYsbTjwMyT0fcuqDNvGX0UcTMRq+m+GkMZYgXdkqebP3/1
	 6q3XCwZun7VPRf2CL+9XXCoZolpkOr2MWLsoC+fgRDBpSmMKZaaBnDBJe4i9/BaL43YoZ
	 B2jT9wnOl9PaSZ5Bsm79Ffemq6GeexuQqMO/p+/1PeBMdfcVECmRk87ZGyXD7iKFlQCce
	 /CBrgMHplZ6dxxDdQIfAnL4MuovaZ0vmwHpEcsBj3TAshkDwt47cde2Q5IxSHSvzFTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792944626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kI8AZKbkyFQDh3fWe2Ucjc2rZL7S/+hpSffclpLVllg=;
	b=ITPay9Waeyj0B9jOkRMfPAsizbpv/jSfMGR8f/sRM5US4uW9ZqrnN2l8IDYDxsGEeY/o
	 uMPRAFIrrP8rzL0Jin9bk4FF6G98ooxepBXfVZorFa0dBqUl170nYZBU6NI6iZvbr9fsg
	 MZ2j0e++f2j8738XXZzgasuZk9E0r32NfZDgaap8FZhF+fNx5zozZNJ+mKiCKK8jUSp5Y
	 06tRb7u0/u5GzQz70ZpVY0x/jFKn7pZp7qRGPPaMbmtFzRpXCFKCqWRCpXd2yw7lD+uJP
	 WVPAvy865Ajk/BN9UCYNYNAGBZUPrODWH0kfCrcNr7z5hnfXPLocHzPy5JvpEzBbPig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qYpad43G;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FEE606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 16:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37FEE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qYpad43G
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c5358fc28so2087070f8f.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792944625; x=1793549425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kI8AZKbkyFQDh3fWe2Ucjc2rZL7S/+hpSffclpLVllg=;
        b=qYpad43Gp/uZiEgOdnGtjj0dO9omo54vhgDQNKJjCMZiSRGg710/7z2DhUVP2weDYT
         HzBE8cndmQ876KcaN2/yw0KAN4B7OkC5BWezW8SwqlxLy2fZ8t2pJnhlHXeEDiOn+5pF
         jT4fyQ/AN6iE5tI5h28AdqTJSDxBmOxkSUnKUK7+ZOWtw8vbNAPzCJt2ulFSqILwVcOD
         iqWZF6lnoyhzTgvqPmqDAr85fnoC4P3c4vymDolWoshsScrSpYiTv3znQtbqtPnat7sL
         SmbQ+2LNm9ij/44/oXz/IP1IlhG3EOxYtSOImLxjwFWrrYhYDw6JzGdr4p5sBVVq9MH/
         NOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792944625; x=1793549425;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kI8AZKbkyFQDh3fWe2Ucjc2rZL7S/+hpSffclpLVllg=;
        b=lHn/WrUlxL/1u3LWkaKe+LSbMGfS2JVnVd7ZrvBPh+PtP3lyBbtAneRaHbog2nvYxQ
         QSPu4oCtF2fHFucpkUawIYCLIwqQ4zJ9NCL5pGZf8XT35v6mgsYqWgF/KRQenzp3v95m
         OSCT7PqtN8Rqqc/MzH2J6/65U6FonE5im/czkC56zxicJ28gZu/etkgFVteesdiBHW95
         oX8JDM9aJtfDDRy61d8Qv1gnugQyrY5h/fR9nGxIDW69TG55c5EzLkLuVCpoIBUJjw2J
         xVDC461cBnQ9DCNv4IlS9d/ySma8embeyZ1RVmCX2tFuyPyzKI9+qKbVI1Sz+uycHHjS
         JgGA==
X-Forwarded-Encrypted: i=1; AKwUvBwuwELMYsq0oj32MVTJFBLpuUxq4kNzLTnjZfkzqyExLV2RHzTeWeTBaJb69vtjrF26n4hnC/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUO+TFrN8HLFY5Q+IxBDYgvQQbyFR4qCVNg/WiodLaav7RQa8M
	bFFIoWq8HTcelT7OqcsxnmHIGImjl6J3HYSABwjMcyBGSzsQubqYeM/c
X-Gm-Gg: AYBFou0XYWf0IGuzWedHYIRePwIOsE/A5iVKXBD3592Ercsva+BU/9rvV83hrN1x1cF
	kPdhgD+/TsfOuvjJhLPkaop/ofFjgLy6VR0HUZP9f0i6+4TcDg94xwyToCJbzoLhNPih1QvJurH
	4PwQxM3Ol3DnoLAqJuoWtABBIfcSCuqZ69BpyHzNGINrNOUrV9OYYm5QRfruN12/7s5+kXHmmv4
	XWO/pxsj5GKnXMj0Hp82VV/vJokEKei8LkLHCfTBFWAf46mUmr46fwm8w3TxR7NSQzDnq5iytMw
	gSxqsRgHRzozkXEkadnHC4dYANfAgM0wJPkVlXxhq3QSjGUYipRrjQ+BBJWV8BxLNeZHXO8o1nb
	JYJN2sciUh+4+EQWzi/nFlbOKmHJ2KiMDjifiw2rsQ4Oug1E8Qvo7D73NVnjE7gQhcx9yxDVBpq
	dLitop+DEMA3TQzkyjjQOz9HYSv1H16iuMiEt/0i3pi0cLDtZgQiEfYzCPbCnC+1irLN3JtYW4w
	Bd//zj7N49hrXomvvDtslajEXBTEk0lRY1dHvBnKSDJm/ZCVPYXHgRjtaUqbl1z
X-Received: by 2002:a05:6000:2384:b0:488:7df9:3898 with SMTP id ffacd0b85a97d-48e3eba06efmr8344636f8f.56.1792944624393;
        Sun, 25 Oct 2026 09:10:24 -0700 (PDT)
Received: from foxbook (bgu81.neoplus.adsl.tpnet.pl. [83.28.84.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd37f4sm13019486f8f.44.2026.10.25.09.10.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 25 Oct 2026 09:10:24 -0700 (PDT)
Date: Sun, 25 Oct 2026 17:10:19 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: IgorpetinDev <igorpetindev@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Oliver Neukum
 <oneukum@suse.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: core: hcd: flush giveback work on stop
Message-ID: <20261025171019.49c9a66f.michal.pecio@gmail.com>
In-Reply-To: <76dfb124-d488-45b1-9525-5369026b529f@rowland.harvard.edu>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
	<20261024155614.2732-1-igorpetindev@gmail.com>
	<20261025000643.425c57ca.michal.pecio@gmail.com>
	<CAG21Q83f_Oj5+-OPjFdxzmLWnFkjfYhY9ordyO0zoGtxkWEW3w@mail.gmail.com>
	<76dfb124-d488-45b1-9525-5369026b529f@rowland.harvard.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Oct 2026 11:16:59 -0400, Alan Stern wrote:
> > > > +      * Even though all URBs have been given back,  
> > >
> > > but does anyone actually believe this here?
> > >
> > > Hundreds of drivers written over three decades, often
> > > without linux-usb review. I don't trust them at all.  
> 
> If it's not true, there's likely to be trouble when the completion 
> handler is called.  We could forcibly remove any remaining URBs from
> the lists before flushing the work item and just leak them (with a
> warning of some sort -- ideally, one that prints out the names of the
> completion handler routines for the leaked URBs, if at all possible).

But you are now talking about developing a whole new feature of
unclear usefulness (will anyone pay attention to those logs?),
while my suggestion is merely a small tweak which costs nothing
and makes no functional difference under normal circumstances,
but reduces severity of hypothetical failures.

Regards,
Michal
