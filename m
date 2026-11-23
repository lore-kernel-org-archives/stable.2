Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426101;
	b=M+FeRF+eQKDyWdkoV2dV3giEMAAkXqcL8Ue1UBfFOO7P/WrkG9rr6RPqht+DvG+mp6ps
	 E/6Qqd5VnbyVqy4NFAA7V77Uklk89D5vDMYLxdsnmgvly/IQ8qh//4FoPguJ7roONkl8k
	 8eVRI72edSbNsHtk4zIKqebs+4mk481EgHOmdjQJ3/cBBRbLXFT7lvFD0r4zjJJg+o6B8
	 HQnIdqlDwZc/PDe+HJXmP0JUwTEt9bB3Myk0ITZhQkHMfyNBzgI1jLbs+hgnReHSkSTzd
	 saV1HNehvyc5lGe+fBrhBUM5rJDgi/5EEAURCnUcpYBBQiUF/HouWOKOkiK5oNBrFBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xMh8nLDv9y7NsT+ecpEuvl1iTz2rhgn90sr5gGapFe4=;
	b=OJDgue7U51WPbwzLgkH06BfQAbH0x72ZW+w/DI25KgolO4OK8y81vYegV+VfdWh7JHjE
	 QkRvqeBkGaZ8SoCBG+YaYCgdG8rzKhgY7CqGIgq8B3VdPz8Ob6RyUuVs5cUJ3X7GsUE67
	 D1tucn0L6eslegMSry98vCqZZUm3gqmImg6GLFLftzSfNrCyVlQ3Gl305Sro8PYAkoxnY
	 uDLKrGzD/lgIozrGPBNgrxiiN6+4SBM06M5Hq+hMfgH2K4q+4C9kHVyQeV6FgkfB7mjDS
	 BUj4cUFwm4D9e5aTlr0xVNhEvd383hN1VGxWFJ2T8Imld83qVk1ARwcxuArk8IugNCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EIGlLh/Q";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39B606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC39B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EIGlLh/Q
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38564b4b017so3297558eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426100; x=1796030900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xMh8nLDv9y7NsT+ecpEuvl1iTz2rhgn90sr5gGapFe4=;
        b=EIGlLh/Qjr29R3wYSOqe6uXfmo3k6/RWKWo2+0DbA76xCFksTWx1pJ+v/6bKzq0qK5
         647EAPnyjElcZqWDM2MeaY5xI0FEuYdtcTwNcCAURNaiKd9jJ3Lhc9g9Sua6Gz0uEV5d
         ZX6csy5DqvefAbdQdr0UQJx2tQIgSt2LylMsrpPecD0kzkvK0doqqMBwU4AG0t/89rSG
         oT/NHE55yKtWNbOl5Z482vFhW8613MzvUNeMfAmJHPGwPhOuYmzrJYXWQjvvNSZLrx5X
         +Mfbb+xYokZBP00QZiSlMyww34WIeNUYdh+2h/wx7c5Qmt5zMplQjIr6ELcHy54n59p2
         whog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426100; x=1796030900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xMh8nLDv9y7NsT+ecpEuvl1iTz2rhgn90sr5gGapFe4=;
        b=Y7Bhe9tEjDjHHtE/r4azeRDJYtHWWPMW6dXx0y5uFj7FCJmZjTipsLrxHRhEvGgygJ
         cHoabmoi8Cp6k6Ae5ilLducaHyCDQ3UBGJ9Uww+IR6iasaPid1tSUyq5+LKjgXvfYnA4
         ik8R8wxLlqMnl37UvXdPQ8m3oXNAgFbqTf1Y2Elfi1XR6TrEklYrAtZ5CAiTybgEJK2b
         tuJ+IVNEGhGeN7g9ugZiMJl8+Q8cRK5KgcQw9/SdvUzGLlVeq1mT90zTdVIFjMjcl+/6
         4gOOF9d89onIesVI3WFY8O2gogq/Ih2z4HJy1PyZBIuYIssyqZoPIMMUQrOJOFJ0vCQ4
         1UXQ==
X-Forwarded-Encrypted: i=1; AL+hErHShnKFnz6CtfBZhYwo8IauQP5UPU8c2Jaf0vWMnu+4NUoBPiBtoV1Hkld6b5gYwrTVtOTMC78=@vger.kernel.org
X-Gm-Message-State: APuU4Z804sygxB3hfss2mHki9YJJw2/QET4wRAnQVoIbPhWIuYPVqwQ+
	KrG5aypCVeB5BbCwQ/P9UZvMTvqMENkmNgfUCtCh7/4KR05oVe8bVAHi
X-Gm-Gg: AZFdTZfMmv+Ybp0x5nceNLhAy2ugnhDKmn8BQ9SpIxBn2VFD5J1fuzM88s0VIUm81Pn
	Wi9gTfbmuz2L65Z6b8kpHIbxJ4lXLf0t1MrJ6tJiUBaSPuWI1biOofa66M+tje+TuL4q9pgmPXl
	6Y9hp8dWveXeN1lcJYth8C2PmzrmY/aSyJI3wvEksMnQAVFsy2gmjVTFIDgcNzcsIpzSb9nHa+C
	c+DSy9uVxYJj/RtmcTfiW2Dv1TQBQ0oW0COsdXJoAdkW6cPwExniD+bVMWqE2iliqF/zbw3GrC2
	hf75C1LaQfUcfbaeKF8maDlxdlrkEye14VMqO9e1soiChjY5ccIMDefoI8IuQC2FSQ3l6a+dHiX
	CgZOD8U53DfUhG+TC1cIs7gJ1HK3RURsYjC9c9Ka76xeYkriCHAYL7Hlb2nNWL0G7CQWFl5EdYZ
	QB7tU5beJrIxLTtBj5S06YmzngNZ3LY8SvP9DWO69w7v8NLt8CygeA+x9rXHyHCzP6Rb8uybwvD
	uFlnjbypDdeaZ/M5erzm9eiJFNeU7RVLrrZ5DTI4shpiRZN8xjoHIBpH9OuKHnfOI/ZsXtd1VUm
	+TsUnnU4c1Q3neyLQpf5vnpt/EeiNWyyD6LmxoifoSPshtJn+p/x7ke+Gn5BtACG9ixHAeg2Cb8
	=
X-Received: by 2002:a05:7022:4181:b0:14a:a6dc:9cbf with SMTP id a92af1059eb24-1b5568abf0bmr16302203c88.4.1795426099783;
        Mon, 23 Nov 2026 01:28:19 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm19861941c88.11.2026.11.23.01.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:28:19 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] HID: intel-ish-hid: Reallocate buffers for a later, larger response
Date: Mon, 23 Nov 2026 17:28:14 +0800
Message-Id: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

process_recv() sizes the descriptor buffers of each device and the
hid_devices array by the first firmware response. It then reuses them
for later, larger responses. Patch 1 fixes the descriptor buffers and
patch 2 fixes hid_devices.

A pending patch [1] limits hid_dev_count to MAX_HID_DEVICES, and it is
still needed with this series. Patch 2 touches the lines next to that
patch. If that patch goes in first, I can rebase patch 2 on it.

The series is based on hid.git for-7.4/upstream-fixes. In mainline,
patch 2 conflicts with the treewide devm_kmalloc_obj() conversion
(4dd10fbbeb9c), and taking the lines of patch 2 resolves it. I can send
a version for mainline if you prefer.

I used an LLM to help write the harness and these patches.

[1] https://lore.kernel.org/all/tencent_130404E5ABECE66E8D0E70D8E6892C751C0A@qq.com/

Maoyi Xie (2):
  HID: intel-ish-hid: Reallocate the descriptor buffers for a longer
    response
  HID: intel-ish-hid: Reallocate hid_devices for a larger device count

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 41 +++++++++++---------
 1 file changed, 23 insertions(+), 18 deletions(-)


base-commit: 10bc1d627c297097cfdc099377f8a13efdfffd86
-- 
2.34.1

