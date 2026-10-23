Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783776;
	b=BzMWAmDAkN+p20uhR79kIS/ZlHayhHEYL8dqSgdtlg832SbLePEY6nhurAU/HKP414x0
	 XVFJByfK81nQDSx8RiQqjSHQekwowLGpkWN2Px8Nkg40iO3v2VXgduAjXkhO4aUQ7hDHu
	 sKHtYSSvF73+qDAWW8Vu6b5sSejIm9nzLvhaBJ2yoS2zRITmLCYaQhHObI0TeCxW3WrWx
	 0n8pCfzN2p4cG8EqQK64NX1YUxtfeZRkro4KqRk5Qisc9Uc1vCrDN4yGGQkQlZQnyuRFB
	 beya5oWQtKl5zXYgfAzkIeYirtzRi01nwOZXdAQ+ULJfC1GgmxzU/qCYZJ35lirikkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6mn1Ww0z7f0hBkiKdxCSd+R1mw+SIqi/8v/FSNDtdzA=;
	b=SaB8n/I20kv632bMxg7Eo9SbjoSGOPMHGpwbHYuH4IqqjSvD2PqiyLAOwC3ZUpgivvPi
	 JJE+y5CXyma0pLhFhd5SMip2/Gf6U7VG6Gh/DaEZ3cnYVCUA3l4Ol+uWwDE7YVZ62PpNZ
	 ZwYPm2rTrPd70F9cPH7HGVnWyJCYUHtFT/jRLD99kUwmmAYx3baIR7ad+0+OaEh56MVWb
	 J5ckuYl0FGT96TTRAGvP9cOJax6v2dQbrXqKpVX5B5g0VqborwgX38fG1hbbiARMjGiDy
	 4eHAQ3e2yDoQUv48QqEdBIvmqtWd69LVeMHKRBMp30Ail245TFruEh5Zk0Ezn9JQzSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JAaq0BZB;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FEB606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4FEB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JAaq0BZB
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33fb4680717so1232831eec.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792783775; x=1793388575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6mn1Ww0z7f0hBkiKdxCSd+R1mw+SIqi/8v/FSNDtdzA=;
        b=JAaq0BZBYU6590Hp301BXikOqbIgPmYN5FbZMFNrRnI1i3Kml6z9+HOlsTtnxbGWAy
         fLPZfZLe3GsBc7cbkYgh1hm7YsMLLDCQlRvXuRb1PSqhIzH2HdyuzF28Ajed9ip36xn5
         CKzNCKxx+WPf4VGWU/ik9yLmR3ZxXMrdLv/7I6UfdhhZUH4KpxM+qkc05Gi9i38Vyjnm
         kykHOY9dB+tH5vHd3E66cRFwHeLMuYJdnVC0NpTQ0cBHjzdCKg241SaSdffUxrfDhQG/
         Xz/5W//qCWpneILkiThyMn+C2D5grA38zxGiH+WyTLevi0cyWzgBSp0JLCareWCWF1yN
         Ipkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792783775; x=1793388575;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6mn1Ww0z7f0hBkiKdxCSd+R1mw+SIqi/8v/FSNDtdzA=;
        b=HYL3PqajxGEt9C3KNuP+zskBDDTHRfx0kycxu9I9B1WGEnJHUx44+gNLwBhiCaOasE
         DAWwekNV+QEjEtFEvIubjXKHeS+mS7huAAQAbyfznStictp5C6WYMzDI5mJVWxgZ8ASj
         oKvH4w287Xy5AKefKDY5QWesWDmTSHp4tE1wLyLwHQNMEOj1O9THqxybm5P/JYsL65Hr
         BsnzeXtymSHp///dy/fWuvbDYPTb3YZOUe+RXCd4/MhsXngT7AufsZHXgjMNOgc9UGkw
         ynisnM9rN+l98elbIbqrCmLkVKv7+4IuL7JCLcrQ/PS6Xq1iootBZXIYdJ0RuuQAYoyb
         OnOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzG9B84hcoR/MYI5rdwhoWScHBE+1Ghp3ikWsZDspC4ylXxmSPrjrQKaHGozFCWytruJjY1J8c=@vger.kernel.org
X-Gm-Message-State: AFq9FYI035eA512U3PkpUlqnfardaSgCXbhSaBnH6QZy2ShbGDEHOtd/
	n44Tbuio0kbqFsuZYzK3/B7eKM+y1pJxHtIrQGw+HtQNHX6kfFhrTA6W
X-Gm-Gg: AYBFou1W9NedEBKx3Qtmg+0vrGBXa7J9XFG1j3T7y6zrEnmZYhHh1zWqKwTMYbMmUjH
	xJq6pMnJx0+wsSIzcVyZNO5O4scphtoKEZZuiStzNxy5m5UpWPtAKRztCoutNC2cwq5z6qgwRmk
	jQUmn5VxMCP5XnNAoeqfcstVTkYArGYRpIxiSZIxIIVaw2XqzN4nP1Q6hSeQm/sly8Y8gmGm0Qu
	0vFxzS2jIY1Y8HeXOI1m0J7g004M8DyCfo2COX7rwh72EUC2M0ixldrcaEyH6kIuUhyXw0VU4DI
	Hn7kDPYc22AVJnjZsGLGTWhMDM14iuAcGnn1MJQWWu3amigj1JY3N3SkCNKhjn92xiB+sGb1Fgr
	Xjf+qkCn+IFo5lfF2nztT0KkcGd3IzM6VGazf3fyra04pDXEJraMo5aQlyatRQ2wuHw+EvPBcMh
	vGMc/SM7PDPhotLA02NCsco2Laym/yQFc5ydciPEsjS618fS1mte00obw8PkDDM02Q5+EhMEDPe
	Zm+mBPDQH3cIbxazLZV9GqhAr+OxlG07e7SYy4OeMArN/hEZnlhAcu3xgSY7BqK7g7UkiqmUHyh
	Icj9DsXd3KNQ+erGKWXlf0zQwZ6CH9/psHfFg/eakQ0AsLv4p12NN3AnrMmWjgJmJgG+dIYcArf
	OPq94A3IFs0Q=
X-Received: by 2002:a05:693c:69db:b0:369:8d31:a902 with SMTP id 5a478bee46e88-369e836af38mr406889eec.2.1792783774526;
        Fri, 23 Oct 2026 12:29:34 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm381308eec.25.2026.10.23.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:29:33 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Sat, 24 Oct 2026 00:59:26 +0530
Message-ID: <20261023192926.228467-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022140615.30710-1-kapoorarnav43@gmail.com>
References: <20261022140615.30710-1-kapoorarnav43@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Oct 22, 2026 at 07:36:13PM +0530, Arnav Kapoor wrote:
> ams_parse_firmware() allocates room for ARRAY_SIZE(ams_ps_channels) +
> ARRAY_SIZE(ams_pl_channels) + ARRAY_SIZE(ams_ctrl_channels) = 51
> channel specs and lets ams_init_module() fill them for the AMS node and
> each of its children, without telling it how much room is left.

Please discard this posting. I sent v2 again on Oct 23, please review
that one instead:

https://lore.kernel.org/all/20261023185652.195025-1-kapoorarnav43@gmail.com/

Sorry for the noise.

--
Arnav
