Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941051;
	b=q0JxNx/c1eYaYPAToL/KgL/oT2Dm3HiLRuufV587TR+Ta0pjNPfNuD/JN6zRLsNY/bIr
	 yZ7iq9d2E5DPyp6FtgGvUP2153P3eUO1dPfwhvwJBiqrdyuKEPmBYFpVLd5pYvCUmgfQX
	 I9zuQUuQXL0kzyEXDZpLJMZZPciRkAFE8C/GEyCdUGotoFFrXX+/KmsITnDEwdi757uzd
	 +N4ylYrJKOhQf5nyLU0gjv+EcNy0oy90FcwcCyZwfedjxupj7RKmzQTfPxSFRNodX3gBA
	 zDSEPO6JxAHpLPEtZxHsXBksXwIMu0CdThRe1kvHPTXYIlfu0bfu6JxgcUDWaC0i5qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6NWM9VuPZ6/E/oWJvm69QVGVJxdjPEsFNw978dAXWSo=;
	b=SawJ0WZSFUVvwLdXHETSLUTO3JX2/G7dFJxpndyEGWU41fkq1554j7qSUSpHqnWmvNau
	 1rLMxisAkgRnCNcVncbDbX5965xBJ9WCCTUBa2BmIf5utRCrM1kiWRa+cTr411aMlPHd4
	 3dao4fEVzDAO8hQFaZQaxYTB+Gz6PMX80axDink+KT9vdUXp9PIn7GHHB4QkJy6cfuml2
	 PtOSL7LexxH9+axcA2sWKMbthpgkF/pK1yg4gBrXXqGvprxAArmvYkUK+/0Ta0B0pzEYl
	 zSDiM225MxA9bYh5x9TZRjBwzmMMqXVE/NS1KemBtUrqMRNSmct4xlKvudO2kA5PwHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rvw6WtMx;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3808F606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3808F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rvw6WtMx
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so402876c88.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793941050; x=1794545850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6NWM9VuPZ6/E/oWJvm69QVGVJxdjPEsFNw978dAXWSo=;
        b=rvw6WtMxWWbI43iYkCPuB4gJ9Eus8dYNAEit8OMLwGh+KLXKkzWWwj3hsdnw50H9nv
         jXBUOqR+Dg9RGu73NqaRWns5sgwb5wu81MPis2oFA9f1g4lNviT8C17JrSbYWwR6r9it
         05W1Vi+ieojnOVxNxVSSpmPa9fHCNpkd6b8B6c6q8IoOr33GfZCx6qLjT3D5NjZffHcO
         +diaV7lUEmhxBIi9a33yA/tU7HyLdIeUb5+CKprTjcIaJYd2XJ2SMaTQyTX61YOPGzBB
         8kcIZFEYXW5kglaeqfq5ojUe08iQjF6io2AdJRh6xpqgThLabca7pjoLAjSgyoRY/eFn
         /mUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793941050; x=1794545850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6NWM9VuPZ6/E/oWJvm69QVGVJxdjPEsFNw978dAXWSo=;
        b=sRIz4b59XExy6aSFuQTHEXOqxVYlekCwjqpQQ2wq285K4h79FOmcuaw68+Fz8vhckf
         m94BagtNhX0et516TbbeDdXN/SQVdIiF5hgyNs+XA2FIpPgDi1pZUsUs3uQ4+il9kqQR
         r1MRaE0zR3o3TSXQFMSsr4y0zq53s2OK11Sf+yXqGCCO3ZN/Rvn8zvrPZmj9azjHGzBI
         1smTDIcQD8PKofSfW8KhLg5TQ8xIVpES17/hSiQD20nmp0mCbxWycaV4As3N4I1GWDJ7
         neBmCOXx1c500Lh65QdodAlA57uosUz4UQRWmEi1uikCiXxCeBljfz3AsRwZbuR0Z2Uy
         O6yg==
X-Forwarded-Encrypted: i=1; AKwUvBzAZY6iY/Q5oQFncvBB4CrbrE9t+22UO1iuniB8ssl+E2WZJH95zCBD0w76sKHeqEHA6Yv7Dc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7Eb5PItVRY2lkMXD0T0eiJHlVxYu65iQR3X7B9pr1NtyD05xO
	itqe0WfW7egdJFelbrgvzyBPYK22pnisFvfYNQs5eQecU0rze6eZ/1xj
X-Gm-Gg: AYBFou3ZeMvXJ2VmoaKMuHzuu5I5PiP92C0GyIPk3Y+sLbkKy2JucfJw4tBrglEkhLi
	0HAZPCtv+t6228mumet3qfZkw8QnlW/pW9IOH3b8S9bb+otgvyLqJHsOHc76vcx6F13jkfQfDEc
	/znLMpUs43b+HX61OfFY/akv0wSrBAtFB4H1hpOoMhLBCUpMaV02JKiAC/guIGzbbbXw/ZrGaGu
	oPDGGpCL4HyPU4O5OX1jzpEOGHdEci3TV1Ejl4BXFSSDpTAvkwydqubcIB1PUcSkauG5cSH7WUd
	4FehdFgrBH+JriaEd2GfDEbOG3jsRSZU+EBm48gWArVCCoqshMK1MB413P4d/QRDHdcoEYOH9F2
	pnmiE3YiIDmwySWPdJuw8foaeEP447yt2tLIOWmbL8eaMuYg35FjI4hnBhWhMWADmx9llNwF1BL
	w2XObFWnXA625DH9APHZXnjQPVQNwvp59j1qngGSilISKL9ksJoxoanQuevx0RGGEs+ePwYCCKj
	CixBmD2Qi56H2fVBw+fl2u84Orr+Dr89j9MMiTQSteUB++HlKD6G74tujBzwFxa105RhjhxZUQV
	KZxkHFL3UJpsb1SriNhqRTPtx4EK3EkCdmQVbDSwCePZBw==
X-Received: by 2002:a05:7022:f51c:b0:1b2:43b3:a90c with SMTP id a92af1059eb24-1b25d3153femr1419262c88.9.1793941050171;
        Thu, 05 Nov 2026 20:57:30 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4c41eesm3038969c88.15.2026.11.05.20.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:57:29 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: Re: [PATCH 1/2] ntfs: don't write a compression block after a short copy
Date: Fri,  6 Nov 2026 12:57:25 +0800
Message-ID: <20261106045725.3047943-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <au0zsi-oLfcprQxI@hyunchul-PC02>
References: <au0zsi-oLfcprQxI@hyunchul-PC02>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hyunchul,

> This patch looks good to me. But the second patch in this series
> appears to be missing.

Thanks. My mistake, I dropped 2/2 before sending; this patch stands
on its own.

Thanks,
Zhan Xusheng
