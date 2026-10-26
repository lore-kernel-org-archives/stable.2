Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976314;
	b=oCzOgOBBXx/E4TzDpby96hvYN9GZ0EjioEN0244+10Q+/DivD62ECQdt2uVt05balcNW
	 Qpnuz7ff1WJ1SBsvFC8Ns2+6zRoTq9f6FWG4cbXOFgzbgyDuvvb+SJCFyDHgRzaAOv2dW
	 ZcQPC4a6ZZOXmFKJWGjlakeIURuw8lgS9KiBzcAY0AfcB8XwHKcORyj1lTE9jNdhftTZ2
	 IOD4UJgN/03+h+BGvSTlCfWA+vGZrqYn3rhEAFLpDBrB2Ms7dJ1nm3Dv0T7ffK6CJGYpo
	 L+bDLSftJ1+vIl84nIcmbLX+YdEywwXAFh/Ymf/WLqMITKcAhVyAB7H4/RYxxURER9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=V6XEtkWxuej4IEYIwv0eUDHd5HsULUW/pPlJVdLGiWU=;
	b=tfDJFwQKWD9MyTyB4zg1lf2UeR2yabeSZrTZp6iejI5LgJGAnNKG4+p5xdHJmTjZEcs+
	 Fed/ubMzClg8uqLElahpeDWC5GgXFYkc4tB9iUqIdi39iGNlQKVZ8yx7uAziyo8Z8b8DR
	 AD2THSbASz1/hzCkY7HY9BRmBxqyLhaGUeUTA6qaorNnHjsc4a9OuRdReFqczfAFAGkJE
	 Lyef92wJq7qyDP3sQAskEVsgi+Z7H+gRd/8lYAeP/MnqhmoCyaWtnKktDiIx2E0zAmopl
	 Kl0RTnZfH4VXIKFSn3WjbPsZEEItfpUVnClqf8nJZZfb5LFSqP4XZnjkHIZel1Zutxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f+CAz1ZK;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C6A606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 00:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C6A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f+CAz1ZK
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a264b6a06bso923529b3a.3
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792976313; x=1793581113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V6XEtkWxuej4IEYIwv0eUDHd5HsULUW/pPlJVdLGiWU=;
        b=f+CAz1ZKWhBKwDsPwUx64Uky52lZvae9T64JKjHaNee/0bBgrRCJvH6GzFOuPRcqNJ
         fWNWnsv4fLDSSgDXv/1mStQdRmFa9tY44zaBzg6/xQeeDNcTYHTbfdzp+dmwLLRbsEtk
         BTRCD7wZYH9sOuf17HIgIq8Y4lOuZGRjLHYIdaeRLOv8oJw3rx84/DTPLOTxPCpiFZml
         EfOolz6iO7kdUQdV5abRQFVvcxrUw3RDv0LDhRAfEe24zkWqRlqF/Xea5VgZ+4zI69Gj
         qok77+IPJX8463Vi7CGb19Jdecyci/xtKFJLijT0b0kC3TgsgfF15SyAbrxo+odt/9cy
         g96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792976313; x=1793581113;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6XEtkWxuej4IEYIwv0eUDHd5HsULUW/pPlJVdLGiWU=;
        b=fS9fkpa04PODDjU7cs0EyePMSHHYqTCOm7mKv7A4EZIrJKCB9XLBXJyUsYyDSvXZcH
         h4Vyrw/sd0+W9LeAfhYzTVFi7tULeujGm24jFCJqxektkqPdpkr9JsXxXYcfgJiJiMil
         WGG4zW5HbznWTwKdlpZ/+pSjO0qG5HvKThCY96/ITAkiGfP4rQnSsJNwzvJrdKOe1X7b
         lFJU9IZ0sV/yHv5Al/meN96nbxI34nX1Po+zNf6j9a+Fr92KrqIRPgQDB/D5Fde5g2s+
         tIHnbfbMdihcX8pRYh5tafQAx4Au07R4zMUy4w8iY9nk0NbLmUwbNbetf0IVK2jva9w3
         MElw==
X-Forwarded-Encrypted: i=1; AKwUvBzTjUmRYXZfmMzBzxJUM2zVdRV8ouRNCD7C6NFUM+9e1eOK5fIGMv/wrRdUr0Kb/jeSF2/uMR8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEV9jIl7g6zTXVLrgDBp0J2LflTQ4EYE5xz9nYaecRSghcKKac
	3rGov9o+ZxAE7SqLqCHGxM2AbCkfgejBKJfO75N5WKsG0jU8yUkBB9Ok
X-Gm-Gg: AYBFou2Abz9FNnsb4olK/nRxL2mpK7XzYTPibb7Trr7XjiR2DKiOqyScsPyCwtzWgDJ
	ZsKDBHRi61JLH1ZE0E9gMy4TDj2D7zFH9BPreORKtQArXLcgci56h8WcnaJ9A713fxWpg90ATgM
	y9Q5MxSNLlNeeZFeSyi/x0XPtdbLqI41AhQY8mF24v5j2s2gtiJJ3hzjxB8OVvzG8zeuG/I58RU
	i5XtpOHaJPzMux4LVuws7/5xCWEnvz5tH412MUGEL0QsL5qb+VWpeMu6aymVokxSGJRw2NjzOE8
	SA5iqS8P57EyVs0ClEqn0pOX00IrBAy+QU/25AuHAQF6m8xX8iarsBeR/+Un0x57kb/eXVKG75Y
	Ff1CdrDa9Vuy0WzFi7vLT0wdQ2r/S7XumZee8b57J/E1yeauGNrUu1M0VGouJ69IX+baGt3iQpw
	mLoElOZDy5VFXh71+Ql6q1uSYrtx2cShV95JvdmScg3MbzBJOq4DgZGmuEa+crHduLxhFXTEW5z
	+A+huZSeZtJqlx7sSg8Yq+eT+0PmN4ImMtUbJToj2T8kCoLl4kyVSxN7R13ENgvaj+2QQ==
X-Received: by 2002:a05:6300:388:b0:3dd:85aa:4524 with SMTP id adf61e73a8af0-3e7bfac61c2mr3509972637.31.1792976313097;
        Sun, 25 Oct 2026 17:58:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccd4cfbsm1063454a12.28.2026.10.25.17.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 17:58:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 25 Oct 2026 17:58:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jiale Yao <yaojiale02@163.com>
Cc: Aleksa Savic <savicaleksa83@gmail.com>, Jack Doan <me@jackdoan.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) reject short status
 reports
Message-ID: <aa00972d-b3d7-43df-bd0d-0778e3336a04@roeck-us.net>
References: <20261021120408.48495-1-yaojiale02@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021120408.48495-1-yaojiale02@163.com>

On Wed, Oct 21, 2026 at 08:04:07PM +0800, Jiale Yao wrote:
> The HID raw_event callback runs before HID core validates the received
> report length. aqc_raw_event() reads device-specific status fields at fixed
> offsets, including multi-byte values, without first ensuring that the
> received buffer contains every field. A truncated report can therefore
> cause out-of-bounds reads and update hwmon state with unrelated data.
> 
> The required length differs between supported devices and cannot be
> derived from the HID report descriptor. Define the minimum length needed
> by each asynchronous status format, select it while configuring the
> device, and reject reports that do not contain the last field accessed by
> that format. Keep the published length zero until probe configuration is
> complete, which also excludes legacy devices whose status is retrieved
> through feature reports.
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 0e35f63f7f4e ("hwmon: add driver for Aquacomputer D5 Next")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Applied.

Thanks,
Guenter
