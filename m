Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390480;
	b=H2wX4rCXl815qd/IQQZ0RK7F7Jy2Zna320tJpkLJERau7AX4ZxFdEq2wgbLzzQTq4EOO
	 R09Y4Xgur+P9WdPZOY3xMMkUCWq6VPlNEpAlpQVk7RlF7ShndLbSstkJ98p+2rJbbcVWi
	 H7f3wpGHkPHugvySELyvoAb510bSg5/KgRrz2m/phS+8R2jvhyFte7Lfk0AOMR/1eneti
	 579/DO1XoaTK/cUDEQyxgvWnhh8zVD9u9jnx6yLdOtqy56yf5OBxzQuilz7u7K8qq+xya
	 nrupwnJyIOZseFhm5PD+NmJqI7eZEn3A258CvYMGfK3/q44JVrDaP7fJz035bR7lnXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Xr+9Ecbsm+vbaizQH7M3bFs5ABTxIw+BtfIU+UNFjy4=;
	b=OVsiawd11Nv8F/glWnbjmLyFA3/Iq6iJ6oZok39CbKDS4VzRwaFefcrgAOzbwKe1QpQx
	 Yan/GCYjJVtKwU9S5pcQP9FOe/vq8o9L/bydg+X80R7YzWdLV9OYm+lksXllaO6wDFw6t
	 xEe/Rc+m9QL1K2glYkJ+izhJn3LQu2O2WyjvgmcBiMXGooC9CyPm5b8EPIuuCkxSOzLSP
	 pbTMkqZOVroKfOR2+qUSGEuIeMOXLhzLbFPtfLBw0lpDWTC/Toq9leN++/kh0++O8wcQ8
	 UCFmNdhacvQ3mdH9l/cYej2Hr3ZptMr+oBTwfgmhWuuUYjQxoipn05labopX4IL4f7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DFCo1pjU;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57D606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C57D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DFCo1pjU
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so25909125e9.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794390478; x=1794995278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xr+9Ecbsm+vbaizQH7M3bFs5ABTxIw+BtfIU+UNFjy4=;
        b=DFCo1pjUShcB8dERsebFrOr2ieoQTZr9MnbAgH9H0BL2tq5YyCSSU02xrx3rfPmgEg
         kPBcAt/pwcMd0rej2x0MA3SeJBXM3UuuPTGSN3BuuraMzkCGEzz6d7kMrxBxIm25aYGW
         LlhK6mVtLmN22k1US4rteSJm4UCa67qHAMGm0BMJGqh1us5p9eqOnnbv8+fBa2kG4TM2
         ESueB9pj838LCByfQu2Wsgk0/nngl/AZi3kOuEShNj7WTerMOWk6Rb3XfV4Jv4bSnEKO
         ch+tb00lm2sFu18tUsGMozRFveUd3pobuN78oXpj+Lh76SJQ/CiO39/ob8+Y+c6pLLUS
         oOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794390478; x=1794995278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xr+9Ecbsm+vbaizQH7M3bFs5ABTxIw+BtfIU+UNFjy4=;
        b=QG4EsPVsyY9XW+fGH6c9qHZvgZ2vabVrDNGJaFgBR3SeXXpy8tHYIh+/cv5kGv1lR+
         A049ecxZFArcsV0stohu0gy1ZVBducIwWrGuRAQQd/DUnd5qTX0ck7AXq8QsprPomdDX
         bGfXeJKF9dNC0o72HKeSgxsWvyT+mmxKYZS/HfZKrrFQE2dR0/suD1oTcpUIawx/uoPI
         YKeegNgl3NXuBjwbVjzuMnPa9TDK0rJr3QI6iuyWGRBLXeoDoURDY+wYhKg0uoptVnBD
         1uF+U/bSG/buvGu8uG7G+bFLM1gfvU4yqaTTPJj9lALGymKjC0HtLPAN7+5NznYLDnsI
         CPAg==
X-Forwarded-Encrypted: i=1; AL+hErHbaHMlE7OUkLam9Z7bB8RKIyxDtwQrtkOnfiZm/nbOAsQbXQskA19o/Pfik1HZNZ4j9eul9xY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RmeMuPysUvmRnb2b0Mb4+YrzSKUgIAroTcfcaqlqGLS2u/Uad
	vmL3v37HrBRWwc84VvZl0mBdvs9t02Xdh7pyuaSEpAo4ZOzEWP6RwmHR
X-Gm-Gg: AYBFou2Msajc9nPILXMMMz/ChjHfYTdLOFo7tk9hC9XKEgMcmBjY/OjqY+yb2cdxNn5
	FECuKuW66OZTCfS8YpChLj/gMZPa4BlOEEz/aUuXI9ejts3yRjEA3OX8pCvbAw2s10ps5MTXubB
	Pi5zzVPx3RS7/bwad4V45UJEITJfsTQZEwhaeb2/pLWVHJc1L4ZoZUGDluYyVSiyE826VsDa+eH
	luEAIkMuIQfMZcTyNv2vjEw5EU4qm6SNivCc+N+W0vcw+Ld+RdudiQR1cTwUQNmdiElzTUtE2Pg
	QYSCE2XwCOOaXMkTM/hC6qdCCyHsw4t42LQTqA/CGHVHDrfQHfS11UBg9610PL3G+3cCNxIl+o8
	HHriqZa8031gM8MojXYSOwhL3CdN6K626h+MLttKhCH0+MjNB2GYQUGTltngBiSWyLMbYF595i6
	bH+Hml1m/nuxWmU+Jl3iPlX6UjWs7rSISA8Ur0LAp7GfBguThxfOa5XLjs5YhyOz0yhnczziPsa
	fW4nbqm3k50A+7h6NVChsNKXnAVyHX9/72vCoMresNUPiGTq61+8GchawygbwAl5PohoAoQ/hMc
	JYdNAW4zFK/V5J6hOkfpEpNQQQoBMMnBpC1buuQHSjGG6ab6V9AcqWuSY5y3aq+d28akoYnDNjd
	LpS/PnO+bSifjBj26af7eKMtszPihAFQ2f5dLSGaObq4R1TWNkQ9+md6VarxuK1zm1UE3kOuutu
	dJcbOFen1cY5CaoPCAormFQEqon0qzHjzUEKpYe7jsdZit0h4GkNpbyA==
X-Received: by 2002:a05:600c:6308:b0:4a7:b304:253e with SMTP id 5b1f17b1804b1-4ba09381867mr34638075e9.22.1794390478233;
        Wed, 11 Nov 2026 01:47:58 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-a1a4-8dbf-7ab8-e5ac.ipv6.o2.cz. [2a00:1028:8388:a84e:a1a4:8dbf:7ab8:e5ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea9eesm203884135e9.11.2026.11.11.01.47.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 01:47:57 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Ignat Korchagin <ignat@linux.win>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH] dm-crypt: defer async write submission to write thread
Date: Wed, 11 Nov 2026 10:47:56 +0100
Message-ID: <20261111094756.20997-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAOs+rJWmmUbYqU34Yb4qJvJsZ92=AztNwNsqX+xD8WaH8tVz-w@mail.gmail.com>
References: <20261105072708.30722-1-pepe.schlehofer@gmail.com> <CAOs+rJWmmUbYqU34Yb4qJvJsZ92=AztNwNsqX+xD8WaH8tVz-w@mail.gmail.com>
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

On Mon, Nov 9, 2026 at 8:51 PM Ignat Korchagin <ignat@linux.win> wrote:
> At the very least I think it may be an unexpected/undesirable setup
> for the user: they enable "no_write_workqueue" expecting a fully
> inline setup, but still get io offloaded. Perhaps in such cases we can
> do a pr_warn_once() to let the user know their setup is impossible?

Now that Damien has confirmed async is fine for zoned devices, I would
like to add this warning as a follow-up patch on top of dm-7.4.

Would a pr_warn_once() in kcryptd_crypt_write_io_submit() be acceptable,
printed when an async completion is sent to the write thread despite
no_write_workqueue? The other option is a warning at table load when
no_write_workqueue is set and the cipher is async. Zoned devices would
not get the warning in either case.

Mikulas, which one would you prefer?

Thanks,
Josef
