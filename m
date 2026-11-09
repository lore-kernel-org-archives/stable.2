Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231539;
	b=ai4/Sv8gqRZdBtTeMUjrLkIbLz78OAE8hOENRT+uEz9OJhZkEHVrCpeO1XJK5jLhnIAV
	 E/uTr7ZnzuoxLhgl8EncauYScNnzKD9xPjP7qLI/QpGg7N0OhtJhQQpEt7n2qfOoZPHO+
	 WnodleVu/GemrBzzI9EbfDveG54lIVPOuATmReaOMi3pq1W3U1Pp/BH0mE0dkAVsRve8G
	 F+7LfVq+kYyi+bQ0+kwqmBZ6VXXgkSY1CILTHMQRaNbyzvq0R0bT40sd70zVSY9ZIdBm0
	 B8G6c11PZsHQOUQzeVK/zGmg0hwhMHbeuW2upiS8I5wuOSPVTwv4L2eKafMwqSFHzyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231539;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A4U/1Cl6GOHBtxB2eTLaAr27aNzRejHhcw6K6cN5W40=;
	b=JLhb5cOPg2WPENykhkvZTOUvyC3c5SR+GpmX0mTFo2wjM2sA/kuGD+pVbiVLKuGEGY8v
	 ZkfcVqOA9naFSntbWFzw+OUEYVRaX5ReQB1D7okrJZzaw5gJ0GYizmgn70mN1ifXt2Ysa
	 o7yr+c1iLgebdEt8Lbb4MZ8vUoKVvAtLx7do+HKSGAttIG5KYz2Owl4OvqFqI1QVRE+CT
	 QYAN/2psCLpA8qty/dHa10Swma8ejB5GujkP5JEWnWMLhbkvxkpOkfwBCwSc2SJB9ha1J
	 uxXBKLivLex27lk1f9qRDThs6BfgEwn2arh153gW5f8/2cs5Zki6Ra7AhaqB+Xmhazw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fh1UQVKg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F0606A31C;
	Mon,  9 Nov 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fh1UQVKg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E389D1F008A1;
	Mon,  9 Nov 2026 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231538;
	bh=A4U/1Cl6GOHBtxB2eTLaAr27aNzRejHhcw6K6cN5W40=;
	h=From:To:Cc:Subject:Date;
	b=fh1UQVKgLoXzdt8+OVgr9j0fY9Q8C2rR2mhCr5w8u31LFo0hjjqgPaHPzzmREJU/k
	 IHvyu+0Z6XR4RsSukJYHSMmfFprOz0US1XOQJicC1r6M28/0oMjTBxLyxyS57vzUta
	 Ql5CldoMFsI/eYMada2/adUvZs/a8Abu+IRthPOgni0kgBDgGDXhw7GkVKGTJ5i5yS
	 +ofNHl5L0vENjZ7mibKbg4EuDjsrzC96aQctamtojs61Vsd/sewRYEtXL0MZn6sERK
	 UUVUcN4s99MLubhiwZ150N0MdAo8izLgur6ClnIzONcYnV+JONm/MMpJtFuoismE2w
	 0SFZzdrHeAGPQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	linux-input@vger.kernel.org
Subject: [STABLE v5.15 0/2] HID: wacom: Fix Use-After-Free vulnerabilities in Wacom pad handling
Date: Mon,  9 Nov 2026 13:38:49 +0000
Message-ID: <20261109133854.3026082-1-lee@kernel.org>
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

Backport the remaining two Wacom Use-After-Free fixes to v5.15.y, on top
of the five Wacom sibling-lifecycle and SW_MUTE_DEVICE patches already
queued in stable-queue (queue-5.15).

Both patches have been adapted to the queued res_wacom variable naming
in wacom_remove_shared_data() and use explicit locking calls for
-std=gnu89 compatibility.

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Ping Cheng <ping.cheng@wacom.com>
Cc: linux-input@vger.kernel.org

Lee Jones (2):
  HID: wacom: Fix Use-After-Free in wacom_intuos_pad
  HID: wacom: Fix Use-After-Free in wacom_bamboo_pad

 drivers/hid/wacom_sys.c | 50 ++++++++++++++++++++++++++++-------------
 drivers/hid/wacom_wac.c | 50 ++++++++++++++++++++---------------------
 drivers/hid/wacom_wac.h |  6 ++---
 3 files changed, 63 insertions(+), 43 deletions(-)

-- 
2.56.0.506.g506a7eabc5-goog
