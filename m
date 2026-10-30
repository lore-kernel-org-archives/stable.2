Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322935;
	b=Fw7sBERNg9kNvYjeSJi9oCv3svoFmMWjF23jT4BrrIGSUlSoA0pLiFHs86zstsf3czEa
	 gfLisLxJVfsRSxjiePSpKJIryl+L3j/SHNcUsrLuWQnHUtF5EWqPPMTHk0LZb9lggZ95H
	 h4Vskfnqt4dLYyKgaG/0ktAQYdpCZ4RyVk8GvBy7phtKaQgTcoYB9/9RRmxTksSDilKY1
	 zoFO7nQabtGYMl7RZUOp4OdD6FrGPJjSUi4aOZceliMrVIh7fkjn5SdYvcMdPjUlXL1WS
	 Lk3vpyTbLuqZ/DtoEke9eXI4sQwZDxjXbrPkVuEiCgYg/N3qCZ+L56jUR9+z0L5T7LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322935;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
	b=YY/H2jMudOtXpgjTIBDg2TqpKL01KHHY0hb7xlAekv8mndBLqF9tD0mxX6Di7FIvnReh
	 v2OpBmRYJMKkaHgwO0z3/NV/xE5zakH0l/yd1mWElnsoW8pWVYDAt3UqBJRx1lTtYcNeO
	 N6L2cCWw049z+AS36GA2H5CJ3X/7j0B6J4p4hWvc0Na9oHVpn9CT/G8Fa3/IAPnseLmPl
	 jIhne6mq7UaXJsHvecbm71njE+jUaxbdLQN8vmkymd4OEqtjrrWqYzAHyfdEK8rKUvTTF
	 Vw+TAEgR150HgdSStg7OSjswHFBcqkOLF6zMqsDDpRxEfv2ybrtpvJEC12d50mTTQEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Q7k9JNio;
	arc=none smtp.remote-ip=209.85.222.100
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47508606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 01:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47508606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Q7k9JNio
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-99059bdcdeaso45977241.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793322934; x=1793927734;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=S9osF0+ewUt/Rq+QFkxC23UJ+d8JkMxsi6W/ZUVRu1R/D0twUAXLRMD6rBXx8rLvOm
         XvUbT695y4QQZkzvZ5zFbmlb4c6CwmCYQ2aqOP9sLRQyxRyyec3/TxQqyN8mENfxhvHF
         58tjYivaywV17+sZxo+5v6B9wOLyPzAxFzWn5vtX45xv60n+LKLm1BxrZt2cPn3MDyef
         ZXvUSUwPQ6wcoCXlK0Na7O1vTOf6x1KetfHlanEq7EmagSgQvGpUHk12XwFtbYqDCsoh
         4s0csp2KitkRJt0I1/aDY4MAjNa/WrtBclNXUS9JbFmeAQqOINKwViTcIVqoSyq85PeA
         D4Sg==
X-Forwarded-Encrypted: i=1; AKwUvByQ65c4H1XHF7PZWNaORocLSqaNqwma346E9GWMl1V24hYcuEO5bK6XVhpaA9OxeY6weHB/tlM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsbmByM41JVsuz9X9bT80Nw4u/aoKTDImUTFarOr/2D3OzN4XD
	LKtgKqjwNrVQAgy+XkXFR0sDIBTlcS6Y3A8DYQAaPFmeJfrrwLZzrWcKCNwfJCbmKjwy0PJeBBv
	L6k/DZBqxFkyL5qQ3m4SDGoyRdr/gebrk7TybosUcZgNlK1ZHS3yBhfHXzdI5LsslALbvJyD76a
	NJTPGBW4/2lcNQS4IWuGaJNzgnPzexkKA0Z6OJW7eP5hMM1oGpJuySAUsTalb3f4STwRyVgrhHH
	qC/td7jdMTj5tf7
X-Gm-Gg: AYBFou05ofQmFDA8DzpVNVcr60yQrdU14beYHYnuNmn+zRbOgFKm0yShuFxLil6uZ1v
	7mQOuXJeGUKA86F06y8Q0Bw51/7bSwmhA1+Qtj+c1UdDFF+eYSaNc2GqPjgbW2vFoYwRDd0HW7k
	pvqFPpbf3qeBBqhde1CpRoJLkR8jziBcnMRdrfRfLFPxSMzgsTmIoFxrSApY3//wV00xi8KUqlk
	s5EzIgOThMu24S9HkD35BZqB3Zt+36GFlr79gyy1JiN5b2JdTfngQ2KrWTKCdh0Bv37sVgfhSCA
	SSx9126PRYakjiPChEI9KXeL5U2U2AsHuPtBl+Q60RSe7aRbCOExcMs9dthe4DybMnWiu7E8x2h
	+zGo/pcQF2rtnArvYgThXv2oj9VTbCakFIiGStYoMeYrMYQwB7QrH2QHf9COngA/1C1kQtJzihq
	8XxPQkQEDRwkNDN6HV6TNxOz9HHXtSqyk9Yhua/ueG
X-Received: by 2002:a05:6102:9d4:b0:7ce:5952:125d with SMTP id ada2fe7eead31-7d0728d38cemr429407137.36.1793322933887;
        Thu, 29 Oct 2026 18:15:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7d07756ee73sm3100137.8.2026.10.29.18.15.33
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 18:15:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-542fc619afaso777231cf.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793322933; x=1793927733; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=Q7k9JNioBTgwrwc7tAzUaUy1vQ5bWN0HI+pJ9G3yKvVOSFaDULewvCwcg0WpC5DPq5
         xf3u/jdYSZjLZjHiU/zJ23pZuzmelg4XS5EuCGuLhLdRr0q+DE0FK/SrwQ+IGIgsqRvy
         ACtc/pQsKmBbJhwEFECMcwvZ+a7v8uCUMKDFg=
X-Forwarded-Encrypted: i=1; AKwUvBzpddS9a+q2ivwCYfqc0L58cOmTOsqXHM1hMqzhoa2eas8wWZHQPDriqvu2wySQiAZkwxYTVJo=@vger.kernel.org
X-Received: by 2002:a05:622a:a58a:b0:536:aafd:972e with SMTP id d75a77b69052e-542b62a117bmr12705011cf.24.1793322933041;
        Thu, 29 Oct 2026 18:15:33 -0700 (PDT)
X-Received: by 2002:a05:622a:a58a:b0:536:aafd:972e with SMTP id d75a77b69052e-542b62a117bmr12704691cf.24.1793322932526;
        Thu, 29 Oct 2026 18:15:32 -0700 (PDT)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54312a571fbsm269521cf.23.2026.10.29.18.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 18:15:32 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 18:16:53 -0700
Message-Id: <DMHRYAXZQ0NV.QGNFOA7HDQO0@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: log MOB limits outside the manager spinlock
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261029215700.3009996-1-zack.rusin@broadcom.com>
In-Reply-To: <20261029215700.3009996-1-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

