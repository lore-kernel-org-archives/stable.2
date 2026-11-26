Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679760;
	b=OjJ4t/CWpFu0es8MtBuZrWTYt9kQrKNt34BSP4cvOr902Sgtjm2sqVc+WvHhbLaQviQp
	 za69hQzVCRPifyAD6kY7u7Nj/Ro+RFnhRubwc9D8v+fXMVd3K+isz+GSZfesvv/C8DZGT
	 GXSd3WbuVXYXDmpb4Zpeqvmt5wophBZXLxeoGTjmBH8yE9SSpUNqR2B625h7SRl95XNfJ
	 NQSiaZm0zVKi/OQFjunRsysxNn95sGik1i30P8C/FyRgNbscXp0lEBNvAY2Q83cbfrrZg
	 8dwR5pmy1fXyty5VALVHjRDYe2ob9PCdIvUiSkWhxp5k5XbfG1MvAMoHkL6sOwQgCNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=crXowXqxLPttCCSWDd6acmRioxTezv7WhIgrsEki5Js=;
	b=ASbYxq/IHP+RMxMihO2OKgyXulmhJQUdk/mUZKY3tPPmdItpx7537142OJguJZufW9tF
	 dGp1XmrtHcA/cB6l/CKoJtsRoXPB2lmi4v2QyHuXsqX3SWWbK642An/GwOZHI0rAS6ucG
	 W1QtbuALOFexgd1FKcL5U1HSyp4m3ioEwytoHmb5JSg6WZ6l12bfpamyGFIp6NrbjAPt/
	 O1vpyYjYBMUhX0TDlbACs2WQoaLAm/q9segCe3nOFtw9JtH0SbRViS2szdGYoWDO3LILN
	 mkpHK7Lq70yaD0OaYapCAjXO5QCTA+/y92huPZzciXV+/tAE00/syvfrbFlk5Jyoc/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zY+l7WzD;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9A606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50E9A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zY+l7WzD
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b083afebe4so813201a91.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795679759; x=1796284559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crXowXqxLPttCCSWDd6acmRioxTezv7WhIgrsEki5Js=;
        b=zY+l7WzD5y5mzETCJxz11WJCxbTXZDWG3udmbzxJzLUdjioJkIhkRQyIQv/+E1VPSq
         BqXFqve1CzY3fH43KkKfYEAaKk8NISHzXLZYNpP5CnOiCMQsrqxFBaI/ETWPAUv4lHhz
         ResksybXRFO0H/dNmBpDOjXEMCP/Cn+tOW4oVhRrgLaOP0gbFL2i6YYnPvUGY6UjKGhR
         1C25cccW9uIlB+Xl6SQaWOOCGWQpA3KQNzioZmefBmjzdzkOsZJMRqtOyrmxfyLwNqlT
         4YJGmAkHOuYK1HmK2MqmwNz5TYWfCV4DDbmC8o2iS11PmItMT+X58n4YDAEyLDO2uatt
         cxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795679759; x=1796284559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=crXowXqxLPttCCSWDd6acmRioxTezv7WhIgrsEki5Js=;
        b=JPpnD9WwN1MtNnG/4OkCunp98rs3Oolph6wZWeW2NQ/dYJP6DrbxWePAn9cVWnkuMl
         wz0Qckb1Rqvn8LjeZzHAhkFpB0ZHykPKWCV+nnrdT5WJHyEnF0m4voCPwrAOwAwEq0BS
         uevSSJ5cR2j5f643bGj8DViqHmD3ihVinM3eWTRJnlK5LZtXcOO8uST5u5d/mkk3xKPh
         8DHSizSfSrFTmvW31n/TnWjm9vVd/cx2Ua+zoGLa5vtexoG9xHL2qcKr+hp14mgQ0FIA
         IgDeYHoOJBRTXhUgmEwpCOnnBxiFZsLhVsqXAmzosyerbbPeZl0tcbPdimOn99ruR677
         /Odg==
X-Gm-Message-State: APuU4Z+pw3DlLioElNF6F+X7u6tvcZHX9ZwPZUXYzNlMLNHIghG+ojDJ
	OaLt6EHyZUhaMHV5nc0TVyouj6F5gXOiD8/CSNcmqdtewsvKCeA68FRRmU8/Hsuf5rs=
X-Gm-Gg: AZFdTZeuOryFkinBgSd+aexN2lgRAnZ8Q8M0h2xNJhSnF+qJBm5XGJ5iQ1bjE6ub5d8
	vBPsIoHGjLurHLEwrTYPWEJITx7g/tCp81sO2nx+VdQR7bYVo3G2XcT0r0loKmra5gR6vJkI2fI
	Exd2KS40yCJ/EAABsXe/gKzgGX4RyRMLWH4OZCd36t8Y+TK7/VEfU/Nde3KT5hta45CX2Pa2Tin
	kWnOsroF8A0Agy3v4qHwZHjBV4X+8rT9lIIw6rTSiz3MhH+tr5emPtxmIJ5Q4kZ9Wgg7CSTwDDh
	KBjTHMzliMc8/OJ+u8itzZYzF8fVpGE87q5TIU/ubZpJDWEB/CL36oW+fJ0po2lakWgOn/cvfSi
	53GM8tQMU3jPAZA97iz5s5d5bKnqFqxJmtj43llVTqeJgnprp0E4f6qdpFOfePOQ9OWR0DUgPmE
	rymGSOL4oAQEUzbwvTetOy5Haam4LZlRsL0U/aWW74l6B9qsU474AtDa6SGZr87NInQmu2kkZK3
	KaDXsEk/grLDfrN90JonjlmDo8N3eVuJ/YPQa6/XGb02fQ/HWpXlqtZZ2J5C5mSDSTuqbp0t2tH
	XAlfQSRQdN9BPtv2NbT2oDxzAvgLc/+xOkGm1GVPPGpykrlBQA==
X-Received: by 2002:a17:90b:17cd:b0:3b4:9d6:5be1 with SMTP id 98e67ed59e1d1-3b41c93b187mr31884782a91.4.1795679759440;
        Wed, 25 Nov 2026 23:55:59 -0800 (PST)
Received: from security.datascience.hku.hk ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm10690855a12.23.2026.11.25.23.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 23:55:59 -0800 (PST)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Yu Junzhe <junzheyu1@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 0/3] Bluetooth: hci_core: lookup hci_conn on the RX path
Date: Thu, 26 Nov 2026 07:55:51 +0000
Message-ID: <20261126075554.106-1-junzheyu1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026-11-19-1-daily-reply-0012@kernel.org>
References: <20261118123533.25-1-junzheyu1@gmail.com> <20261119035758.45-1-junzheyu1@gmail.com> <2026-11-19-1-daily-reply-0012@kernel.org>
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

Sasha, this replaces the 6.6-only v2.

79a2d4678ba9 ("Bluetooth: hci_core: lookup hci_conn on RX path on
protocol side") is in v6.18 and is already in bluetooth.git. These
diffs are for the stable trees that still lack it. They do not apply
to bluetooth.git HEAD, so the BlueZ CI apply check will fail. Please
review them for the stable branches.

6.12.y already has l2cap_conn_hold_unless_zero() and
iso_conn_hold_unless_zero(). 6.6.y and 6.1.y have the L2CAP helper
only. sco_conn has no kref on any of the three, so SCO is unchanged.
hci_conn_get() does not pin sco_conn.

Booted KASAN guests, same racer (patch-test/repro.c):

- 6.12.119 unpatched printed slab-use-after-free in l2cap_recv_acldata.
  6.12.119 with patch 1/3 finished 371 connect/auth/disconnect rounds
  and printed no KASAN report. The racer exercises ACL, not ISO.
- 6.6.162 with patch 2/3 finished 123 rounds and printed no KASAN
  report. That image is a build of this diff. The earlier #1 image
  still contained the v1 SCO and ISO edits.
- 6.1.193 with patch 3/3 booted and completed one connection with no
  KASAN report. The racer then lost sync with the virtual controller
  (unexpected command-complete length), so it did not repeat the
  6.12 and 6.6 stress.

Yu Junzhe (3):
  Bluetooth: hci_core: lookup hci_conn on the ACL and ISO RX paths
  Bluetooth: hci_core: lookup hci_conn on the ACL RX path
  Bluetooth: hci_core: lookup hci_conn on the ACL RX path

 6.12.y: 4 files changed, 66 insertions(+), 47 deletions(-)
 6.6.y:  3 files changed, 28 insertions(+), 23 deletions(-)
 6.1.y:  3 files changed, 32 insertions(+), 25 deletions(-)

-- 
2.53.0
