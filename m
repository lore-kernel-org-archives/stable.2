Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609462;
	b=Vh38Gc995kaEEByrrT1lyK96fp4VUiy2J0IiZzxQiDkTpMJvGK8mK4kHD277QEzCJCtQ
	 31KMSPP+Ksbx33Ow4xLnS8n0CPu2xgZlTGSB9uKS3od7h6h4oCCGQ1zgioFNV3MOEBfqN
	 HovdCcpxiQbOS5ocLbMSdLF4mdyYOmgnXUawUuxDkLXVF2H41t/eKu8wkKFZXvuCtoO0o
	 Z50VDpGDgCjv8yTdPHKu9dZxz0nrJ5bWATKr4TEt2Eq5YbZeGW9GEatsmTc8QmSXsF/Fc
	 t1gBNgkrtRTnE+D5smlC4OhDZ5M1vu8hfb9pcc3yBBxM4pt5eZSdVrjNxT/4P52wfkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=wLTGWrelj0c+idk0yjSFfSru2jjojEzphFxpTttWZi4=;
	b=TNzCNG3RZYTWp4JWqoxT65XxrH5xi5Xd8oKEvHhOE1LVR9Ng1GTxN9fAT0HLZk8OQ2Fw
	 t+SktUWyLuv8rbPDIHdsrUb4+NJs3kzumzT+MPwBmgMDTuuIo/xD+4SEa4pl2MOvY1rLC
	 iOGr8np24LK2oonn2wjlfzCTst/YYxripQyy2wmjaH1Ei9j7lkLoiigWlQQorX5hcW7iJ
	 B1LR1keASwc/qjSOPTfpfKvOsL8Vuiv8022bJuVBucHU7xKawTqSIny3rdlEVYCVo/J6C
	 BM4qc18pw+NvHqGl2JdGEhkOLRfKjdeC61wkBTM3RoJpdHWmvfUHfKsv7JV1hk5xEJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f06gEVEp;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB7606A546
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1AB7606A546
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f06gEVEp
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so1973445f8f.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794609460; x=1795214260; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wLTGWrelj0c+idk0yjSFfSru2jjojEzphFxpTttWZi4=;
        b=f06gEVEpf+nIUPLzxBn00CD8mQo78Sn4ieaSM83+IvSkhkebdmCp7jkfx3Tw6wk/SF
         ZsHnMWRDyCbgPtfQQaLEf+YjZ02KcCFawqZqR5uQyRtZ0Js6sBrLjQRYCTuavnTqN17z
         /zZXVF3mO3w706c7IMisnauLDaJR1fee9589GDBa3RnORJ7YT8IKlD40vHhkx7PI5FUp
         5pIgIUCQBEZ4uanEbIup7z9Xnjvja/CM2RUrUT3jKUFHAvA/moU2/iAmYicv1OQpDSmd
         cmioUi3Qu/pMYNA+/eZw3tagxA3pkIZKTciTs2fc04lFPTGNEvUpDz08qZZUQutQ2HQt
         PrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794609460; x=1795214260;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wLTGWrelj0c+idk0yjSFfSru2jjojEzphFxpTttWZi4=;
        b=RSSHveA8XiC0t7yZnfXTaXWNZtmL+LczeQ9do9Kh+/vJrDrwI5invPeVuiNYJ8Ee5d
         jM2wljr9E1+9DYB2X5Z2Wq8b28/NZyvaoWWvO4hnC3H0sksOyyx7nmlXBJspaORPYNpQ
         epOKdnTvuw6AXwpDXaxvwgnxQo1kfYQue96eFplAa6kByk6EdjNruqewjl7Kx4rnS2dX
         Zt9RCsO9asnRHjoyda2qWjwNPq1GbFbiT/i8//pvkDF2cN23laI8W/qiJ3ruIQn49GRN
         mWIryvGgVKwpYGq4DZgjoh1CpGFMOot1R/7xT7/+07+sVUMdE4dz35r5JrkMwLpU01iN
         Zt6Q==
X-Forwarded-Encrypted: i=1; AL+hErF/906GBdh9qHD0+R5mrZdWhCnQbSME429XsQHnStKMz0YVC7yJfvVQMxk2yTjkRggvqpjkoiA=@vger.kernel.org
X-Gm-Message-State: APuU4Z87ZSAnH9Atzg9LiA6S5QbYROnTWf3las2R9CWUT24BVUzxlvyA
	J1vJGCLq9kjAjBmUmOpRIpMmZKn+lY+PTR0IO6dL1wsy3qTym8xp6c3DmV7L
X-Gm-Gg: AYBFou36hGTQYCzmO5Uo0OrGj+cwKHrEU9FZ70Y0qeVC7MnRkc4jtkkMQ7wPhg8IyhE
	y5NQebEYFSf1SisD6wo4+EAWVjRybEDp407+a6tJ6t3wbdOXmnZpztgA6gXLi+bgvoOUCTULD8F
	n/eV2eKpND6IqwSi7eX6IUGF0ipZJ6/hz5YbfsAwi8jMNGJ96w3ZVwSpAa7wnpmK1MPrl54nx2o
	d8Fu3kl5jR6yd/CfOj8tyS1I5JdYPRpglx8U+2UyhFC/86ZHSCOIGo/GKO7mhodffEz5/ts2/YB
	xWIHWdufdIUjf8CNJvIj9g9fqZYccJyvOf/GpAZS/+3RBi20K5ettkUT2TiTh+xXq+5Zm5bb1qP
	QWXeFr1E3sXlt9vCbL+7DbenWIYE+61w/4BlUL6Z4angu16N24oxUhrx/Gm9ws2NqaXtkZs9fUY
	oeZnBwr0QNEWbZaLMfaSWWd8gNbz/h4xCdiaTJJQcMNdPPgdcEY2DGOsezXi6FWajlFLaNeR3yc
	06xWLMNAXxeLo774EBFEEMT6Wn8gRY6zWhAMooo5xScORLfniFBoNMH0jnpSeeRjSdtfWA=
X-Received: by 2002:a05:6000:144d:b0:492:880f:494e with SMTP id ffacd0b85a97d-49c72c9c630mr9017132f8f.40.1794609460266;
        Fri, 13 Nov 2026 14:37:40 -0800 (PST)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm12122696f8f.44.2026.11.13.14.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:37:39 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: hverkuil+cisco@kernel.org
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
 nicolas.dufresne@collabora.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 media] media: v4l2-mem2mem: cancel job_work in v4l2_m2m_release
Date: Fri, 13 Nov 2026 22:37:39 -0000
Message-ID: <179460945963.2677875.8420657163527602501@gmail.com>
In-Reply-To: <a931e754-ab4e-42d8-8555-9a432fe42a1e@kernel.org>
References: <20261104014248.3761373-1-tristan@talencesecurity.com>
 <a931e754-ab4e-42d8-8555-9a432fe42a1e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Tristan Madani <tristan@talencesecurity.com>

On Thu, 12 Nov 2026 at 08:38, Hans Verkuil <hverkuil+cisco@kernel.org> wrote:
> This email differs from your gmail address. Which is correct?

tristan@talencesecurity.com is the correct one. I use tristmd@gmail.com
only as SMTP relay for sending.

Thanks,
Tristan
