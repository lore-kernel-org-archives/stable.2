Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794110850;
	b=0phHt+aY7CsGedgmz9v5Z1kZbokfI1IH3eTBKu3wCiJXxOh/1MsTutNeQBa9upQ/q+F7
	 A2ZB4rYES02yPLkKvoJIF7h4iMu/Ec7B8Ju7eWcpdGu6DVJyhKg7O26G+OWv3V6iM3f3b
	 FxyoYEOAETdx4+DrAGizPUaH/PFIPFR/ByI3SiS5YIGnLA1Epu37PUVttC98HmaCLc/7z
	 S/XI9iPjQof7RiwvQUHUvvCjAVBQvUrDqPX1c70+iD7D+uONfmnmpRMGASiCru60aIMTy
	 t/T7KDepinZV6zCu+6DQX8uQ2ASDcesdBEJTS2vPIJjbuhmyrlK4cJLAqPpaGRfjmng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794110850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GRtN9zT+RI+2mfrHlzv7j/45DTS+Jv89S927Nei8sc0=;
	b=xWriedVhZOhrKt1oNnJ2xFE7oAxcnIFzCGTMjPHhP7wR7bxgNFgmuXomGVhDg6w1Jkkr
	 K1+B/XQoOAHAZwbccliUruew/+ylHtGfdhrsDcPzutYtxBc9aofCPUUtK3+NPu04CZq3E
	 F8yo+tCPZ0Ak74OTv+hbfQrZlzJSWh0l80iqh56uJteEC2h3e0cRThdCQn67C65ywcvcd
	 +/yKM4t0rGbT7T5xKcwy/Gpy55bPMMLrmcP0OevL4SNXKAaKI5595kcnB7ZtzWEnv/jY2
	 L4an1nAhFcxz6KGV7ZrYvy8SrTLubgFvVbRv9vO7MpH/Cl+/zW0G/ARPu8eo2irbK+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DY0nb0eX;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2B606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 04:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19C2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DY0nb0eX
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bb5afa736so14651eec.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 20:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794110849; x=1794715649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GRtN9zT+RI+2mfrHlzv7j/45DTS+Jv89S927Nei8sc0=;
        b=DY0nb0eXXV5BJWwY2eTflbRz2cbSg9GbR+0bvGJGvwUacf83D8L0fcTzZ7kkLvyeUU
         Uq5kJbUtBCC1bCuuhg7AF/8mx9rlT7KN+g+7AxAzsT2nQTqV7SZvK/pbS2lda2FILBJl
         pCTfWShSr43FujykuYvSpLVBtHuzOMltg87K67/pX5aFjyK9b4BbgNTtCNN68dGtoEkR
         IBBhMFRMXeJaE8MJSNVsQb4btq60NVqRsn7YMWcLXJu6Mu/Pbvb5ZJ3p+dBBUUTYLK+W
         zTzV0tx3dzAKlb7VdLznqKlZ2lUDnOKg6y/h43rHHQsoUirsnhhFT7+Q3POUOBOV7zmJ
         biXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794110849; x=1794715649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GRtN9zT+RI+2mfrHlzv7j/45DTS+Jv89S927Nei8sc0=;
        b=l+lzNXcFeUtfn53oSWJrd5lhOFyrPr9tgnomIrue4W/S4rxi35n+6LYt8OZu1TE3Dy
         ebX1dfwqq18+xP2mEYByQOv/iU8cwVnmkbRCTVuMrqVd27HaYDK4ultY+tP/C04/NHTQ
         hxPEPoHL6l3hE0cBYbBFjYGvbG46i5OXoF1fYMvPh7rBkwJYCnrhdwC5aIiTyCe6H3dr
         9SLnDljfOHp0k+MF1BzEIoSNLF0idP0elHx6G6ZODJ8YvRFWtG361lpHsNwd/jMXVgJ4
         5dCQFoxQuebJSEROx/ibdLgBcH8ZKXVQ4N6ircDWadVehIp61YUo6Qq/RZLlUaD0AP4P
         UbXw==
X-Gm-Message-State: APuU4Z/cKhSe1XFIwBh1wbvDFnvxClqq+V32J7WV5qxcfIvtY/ImUcsG
	adD7EE8RDVZVA4uGOe1pHPLOKsI66rKezyIRiHfH1Ut+Y7Hf9lAO6rDhs7rRZcjDhn0=
X-Gm-Gg: AYBFou1pl+Xl/tpSnHkeoyp4yqjGqTmwTPeczBkSafpgJ6NRnuygCnIKH2AM9Te04Ae
	Xo3vvv06Mz8EpXyXaNmrkJ6JUmwoNiKDQj/C9Hm7LTuCtaaQATN6LgVtrDSaq12kQL0ZYdcl66M
	BQuDaBNyVRVI0DGzvEPQBd8tdXl6qClqaaBoXJmF5F+BFDi/DUsJLmcPNXc7spyLCdyc4mS9NH1
	Qf8EMnSQiysBpVsEzsG7HAplbAnwhO2PfinBbbAMWsE2Jy+TX7UD91hq98RKz8yk/7mebilcv+n
	syhxh6i+VRDeD2U5S/j7PH4o1KoekdXLn5CWFjzeY3MhS1rr94aXVtZ4i/o5hZzxUDLkyKo+wnf
	86nGlfr5eHFKPWy1uoEPhQvNeIfCujip4OPTQ4mdTx07G2lQxyhkGp847EM7hiEQMGgVmkL/LZO
	Y0Pjwu84c0qr5CWhU0u7a14VE/Gwyic3CHkObVW6UBtT8COyudB6vV/FHDUV7Cecz5PGABcCAbk
	lobvhiFHC5Rd/iq+jgSiiMCO3sWqBT17iqOhdQ+sv+yEIjSSI61KW/hqczJvWLP+UOJ/e3W8gAJ
	vUB65Zd7phqdWe1wm9j9qLV49LUR81KqGRJjGafEhq20TdVorWwWEydmgCldWmtqlyZtcgoyFKP
	8qdB4Ktk1LYnmsZFnrU8EDb8Cf1LdOngcfxjpKd2OBkQV753D7ewA3mGCQWNdxaCzs+8VLxOP93
	4+ZWiXsRALxQ==
X-Received: by 2002:a05:693c:62cc:b0:36e:66d8:1424 with SMTP id 5a478bee46e88-3725024039amr2449285eec.0.1794110848938;
        Sat, 07 Nov 2026 20:07:28 -0800 (PST)
Received: from cachyos-aura ([45.112.151.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265a16f9csm2291812eec.12.2026.11.07.20.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 20:07:28 -0800 (PST)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	=?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 7.3 0001/1257] drm/xe: Implement Wa_22016122933
Date: Sun,  8 Nov 2026 09:37:21 +0530
Message-ID: <20261108040721.203040-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107134939.482764241@linuxfoundation.org>
References: <20261107134939.482764241@linuxfoundation.org>
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

On ARL-H at least, this commit adds about 3 s to xe probe and 2.5 s to
every s2idle resume, because the GuC buffers are now mapped UC on the CPU
side. A follow-up maps them WC and keeps the TLB fix. It has Tales's
Reviewed-by and Tested-by and a Fixes: tag for this commit, but is not
merged yet:

https://lore.kernel.org/intel-xe/20261003222145.67240-1-navonjohnlukose@gmail.com/

Whether to take this now or wait for the follow-up is up to you and the
xe maintainers (added to Cc).

Thanks,
Navon
