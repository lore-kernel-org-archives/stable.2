Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231555;
	b=gwrJoCLYc0kkYGuU2oTNloefmEdFwDPSB7qihjGZp7Xcwp3FyUX4LlndrzRhaJ21LAqD
	 9rCY90mQIoXpE3viXkHJeFq4IVpG7GPho7ZEcvvxIpeT/Wgb09cKjhafukQlzS/qhDXAx
	 ImkFwc9xAC+S96nwLdhdyzGgF2ZCbVvsZdG3dT6SEtYVO+oCIMM3tH39my2TC0MBAf7Bq
	 lBzmahYHcF9BQRaVBItPv+Qsf7Z5RwXTzfbUS+MWueLDe2DEHOPB9rvFhAP5sVWeo+q5U
	 8aK3G3YPv820mDR9yOVKDjFYN3cVPORApwo5pQYWkAXADEreR7jJbBeF9Ckv/yll0hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U7HDqRxX6rzxbF0EgylNSuU3rwX+E6o76E2jsYa8F+g=;
	b=EF8itcxxic1E7ZQA0sLbCdeHdTUrevSut57mxm230bl4J6WSo0v4klUobhmIjFI4ZJI4
	 cFvGTNuoN3NWg6OCCTWSanLg3KPDGoGyooIzd82vd05e2iHkBRyKssu/jPaYCMFTZMlkx
	 JGRaHzlPF9bxu0UjFNzukLCDMpgRjpY8GL1UxED5i/irBwvBK5V6Gz+cFZYobNpFg6sWa
	 n5wWpjDGYLThvibEPeVds4H5xtM34dSZZE/oD5dEX/hRxQ4MhQCiDt3Gc5FSFJSIcWYzy
	 PHO2KfGaHEZsshwTSCIm90+UOIL3zbPMUUNs9Z+7mGhkIoPej/j6KqPd1rDHlGsnK0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="megFgTY/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC5606D82A;
	Mon,  9 Nov 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=megFgTY/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC5D1F0089F;
	Mon,  9 Nov 2026 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231554;
	bh=U7HDqRxX6rzxbF0EgylNSuU3rwX+E6o76E2jsYa8F+g=;
	h=From:To:Cc:Subject:Date;
	b=megFgTY/QhZsfYMMhPykTu55v7MVO5rRed1GMpJQ7Mp3I1cN6KCKRhSZPo2keKKzT
	 BGl6iD+bUWoTWgOa3d3crXZIoCqhg7mUTgE/CG1meClPPQszK66WJ+4nfvkd6dZaFN
	 YBVlW03XpPrHsda4vxhaWAFWdpZ1UvDEFtljew+eGMJyG99+gDLd1QIXRxKMp2uT/0
	 OwBYSpJh6NG1ejlK474v9w+bR74J2PbxpwJ+6hL6xFdMfGUbCQxckPlVCYcmdTMQta
	 oi9JsG1f0eTtJOZo8oOhvS+nCJliYCKtxMeHgUtPF+/D6W0Y1z3LWeVQXuTl+aYMkD
	 qKyNsHxXV++BQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	linux-input@vger.kernel.org
Subject: [STABLE v5.10 0/5] HID: wacom: Fix Use-After-Free vulnerabilities and SW_MUTE_DEVICE registration
Date: Mon,  9 Nov 2026 13:39:01 +0000
Message-ID: <20261109133911.3026622-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
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

Backport the remaining five Wacom Use-After-Free and SW_MUTE_DEVICE
fixes to v5.10.y, on top of the two Wacom patches already queued in
stable-queue (queue-5.10).

The patches have been adapted to v5.10.y context, the queued res_wacom
variable naming in wacom_remove_shared_data(), and explicit locking
calls for -std=gnu89 compatibility.

Cc: Aaron Skomra <aaron.skomra@wacom.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Ping Cheng <ping.cheng@wacom.com>
Cc: linux-input@vger.kernel.org

Lee Jones (3):
  HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
  HID: wacom: Fix Use-After-Free in wacom_intuos_pad
  HID: wacom: Fix Use-After-Free in wacom_bamboo_pad

Ping Cheng (2):
  HID: wacom: Write shared touch initial status only once
  HID: wacom: Setup SW_MUTE_DEVICE according to the order of input
    registration

 drivers/hid/wacom_sys.c | 126 ++++++++++++++++++++++++++++++++--------
 drivers/hid/wacom_wac.c |  82 ++++++++++++++++++--------
 drivers/hid/wacom_wac.h |   6 +-
 3 files changed, 162 insertions(+), 52 deletions(-)

-- 
2.56.0.506.g506a7eabc5-goog
