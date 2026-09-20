Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B620D4F0;
	Sun, 20 Sep 2026 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789922794; cv=none; b=nsYzRU0N7AY0hMbkqn96gJX2Hw2kZ6pNn2EbivVpQY/tqis0wZeZFmdLlRLoByngtt8V0LQpSufLbAio2iRoVqjY6H8xWXekgcQf47YMuAf5MpMo1lErqd+HPqhT96g63bNbtM22bF4rmcLkfYpU8W81toN8MMClF5S/AWDPplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789922794; c=relaxed/simple;
	bh=cwbVmosMdNzOmzxOocnfv58pq8OrH1rWo/xqEunwrSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kyCskStWuAIfQGRsv0/LG0yC8hD4Jyq0yDDTmz3qdxLTRHKXmTsfSRz4nHIxii0jNWqPHCG7UdS163GFOoSUGaoPZvIKzRmv2EpFKzS2Hph0Omfd4mT2y3bCabCVyYlRiLoXhReVH5xhbjFZBClH/xKA/LmDYJ4I68aLS+HlJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=UC0o842M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X9wF+5TW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="UC0o842M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X9wF+5TW"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D3A814000F9;
	Sun, 20 Sep 2026 12:46:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 20 Sep 2026 12:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1789922792; x=1790009192; bh=o7
	O5QEo6XJgjk53ya7NUf6tNPrS075bjtNXyyBAspCo=; b=UC0o842MA0YITiWKCK
	Fwaw18hMDBypgmfXVSHZEu/HVCtVZVj3OB95BmpD6YxhQzQWzbqV+9ruhyAZMloD
	Wv3XP5tLRBwX8GjmX5fbhaA+8Yj4tNY3Tb3AafEaaXShQHaETYBV+ld4Vs7IjTW/
	UWSz/h40eVCwY7ZlEWxvbx4w33gDz2ofw9VpoEwprWs1d4imAMTIvL1jtyd+HpKa
	kSpgaIetRtnQpt9L5tytq36bWiy6oSD7aLrNAaAhRrcb0AnqSmlR1G3p/+BT0ngO
	++cR0B6Z9+qQ2Rrgi9Nfwto1W01nr8VHQ3aXWTaK+mvXWwNQjH+k5UIu2VPEJ79e
	li4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1789922792; x=1790009192; bh=o7O5QEo6XJgjk53ya7NUf6tNPrS0
	75bjtNXyyBAspCo=; b=X9wF+5TWFulMzcXTJaZKvOwFHyAG7LgudcSfY1NsSEgX
	sDCqiJ4LMvVrCYlJFhuEyEMiLwA12s5Aq8e43wn7isViCsZd4Iij3GdtT1lr+0b5
	IUrWuAmK7A4KRIS/LGQsszO+0O2m37Mtlgqst2qfwuF2hUzUFn1ze3t50vPq0Lt8
	/HZGe72Io83IvTe+/pUHXUsbUPsGCZn2JFhpaKApRf67AB7MRLNDvhE1KMsDg/hw
	iXaaByvWbyMY5/ZUg5C/LJRX/bdu1OI7Zfjuq81X0z0ZxLibeDH4TaPhTuL2UNRa
	7Fm/QVwyjBnOc1AXt3AkD0ZjNcsM8mQVDMtBmmsPKA==
X-ME-Sender: <xms:5w2wal4C7Ty_zN8bJbpe4CleyYMVXIUsPVG9VXbQn5KbA28x7HZbYA>
    <xme:5w2wajnkYSIqNwaUXaOCCbNf7GHL83s8717lwXKYxuSNlsHFUf8S93We3pN7JSPfD
    r8eVZrQn0bCwxaDMayxNlHAhx5v5xMytCfQ-GA3vYDcU2BWD2UuySo>
X-ME-Received: <xmr:5w2waqo2-rBquoAOwwGGfvUBVrp8YBNzBmeUw6AAbmjazbc0ULSp3gW4V7IKg0D0p_xoEcv_diLx6GgyvOZS5X7fqui5eLKTFkudE-3Z9SRsxOuTlAqxxW7seA>
X-ME-Proxy-Cause: dmFkZTGXrODxUxlELcG4cfWRvMFXzpEv1fqsz8KQ1fkVI/BTINQBKMhTazAL1zbP+nt2n2
    TrKt8P07/7Y7YhCdHKf4eIpiqZqnpiRf2y4QlyEXO8EfVNDclckZVWJHSWwZ+rhIANkzQo
    Qm9VGY8rIyfi5vHBM7fCiuj8EuQiQAxqi5Of2TRBPxgan3dCykQaYbBFaFUnl5Jazt9lYV
    /DriiElB2CbeBghZyjsue7LxrjTMwsQ0e25bQHY5g5FquCiKV8ozdcCVEBBQLGEn+dw8EG
    /Hgm57Pkuzs+TQkMi80khBm2kI5YUzMgVm7x+16D/0X+Fe4AFq0yFw3mhxqC2RqImi47GE
    LLlJw9GwpAHCtD8rbxM8T77pF3qHeWEfEIB+xV0zaoSEIC5DqDL3iLt0PJdPOa7Ayd82EM
    j7r3mG14IQa8BrAxVzBYUgPGeKWcRCqtpxPGVGUH+o5S+Z5itMc4x8dlRbNNDRCNvY1ri0
    2W7KF8dvUwK2ypSUfyv09QZe92U/A8JOVyO1PV10JPA6RKgrLvCdPJpqZ8HvAaV+dMz/GP
    aq25aNc700wXzQShGlco2eiriue7jnbCoAPJXVFecG05UKFbemy/tz2TR8p50P+/yEuIh0
    0/WTkEGCUIkR5SVZVVkoQ6+UdMEfy5M6mIBv7W0T0JT90e5n3FZWJSf/Q1XA
X-ME-Proxy: <xmx:5w2waitiq0pTd4fJpB787YscY6fUTTLNMGpu7xq1j-oD5RftB72dWg>
    <xmx:5w2wavHJqQLeP0gfMJuEzuSZzMK5dTW3jxxxQFwB5anmQ6uFUcfcIQ>
    <xmx:5w2warZ8TmTo10LalzX2erUtUuRH-hjQ0PbvW8vk88nwuVVpVKN3qA>
    <xmx:5w2wanVby5hn-Agp6NoN0dqQHKK7K2PuoWm5gygkNRyZSlAaiLnH9Q>
    <xmx:6A2wanP60P4R2d--_dWJF8O1Jd4nb6KgUfsDi3RTFu4l1ueeI2m-BtFk>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Sep 2026 12:46:30 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sun, 20 Sep 2026 18:46:19 +0200
Subject: [PATCH v2] nvmem: core: Fix OOB read for bit offsets of more than
 one byte
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-nvmem-read-oob-bit-offset-v2-1-feeb7b672059@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ7CIBBFr9KwdgxDY2NdeQ/TBYXBjknBABJNw
 93FnsDle8l/fxOJIlMSl24TkQonDr6BOnTCLNrfCdg2Fkqqkxwlgi8rrRBJWwhhhpkzBOcSZbA
 GjXL9qN1gRNs/Izl+7+3b1HjhlEP87FcFf/afakFAmAeUhGdjbW+uD+29fh09ZTHVWr++FJFsw
 wAAAA==
X-Change-ID: 20250901-nvmem-read-oob-bit-offset-dc1c2f39af6c
To: Srinivas Kandagatla <srini@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Dmitry Sinyavin <sinyavin@gmail.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=j@jannau.net;
 h=from:subject:message-id; bh=cwbVmosMdNzOmzxOocnfv58pq8OrH1rWo/xqEunwrSk=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwNvLfnOoQxSc0o/BNr3mU4LUzi/v6s2U7P7q/6tIrzd
 EuznMeajoksDGJcDJZiiixJ2i87GFbXKMbUPgiDmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKq1shkZJqZy72MxmOVTyGsddKak2SuPm69BxelGRM7VoK+M1ttmMTI0cXs3xIX
 k8gWFZUxav2P3oSmL/v85N/uTum/U/Ylcm1mYAQ==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

When the bit offset is BITS_PER_BYTE or larger the read position is
advanced by `bytes_offset`. This is not taken into account in the
per-byte read loop which still reads `cell->bytes` resulting in an out of
bounds read of `bytes_offset` bytes. The information read OOB does not
leak directly as the erroneously read bits are cleared.

Detected by KASAN while looking for a use-after-free in simplefb.c.

Cc: stable@vger.kernel.org
Fixes: 7a06ef751077 ("nvmem: core: fix bit offsets of more than one byte")
Tested-by: Dmitry Sinyavin <sinyavin@gmail.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- added "Cc: stable@..."
- added Dmitry Sinyavin's Tested-by:
- use 12 char SHA1 in Fixes: tag
- Link to v1: https://lore.kernel.org/r/20250901-nvmem-read-oob-bit-offset-v1-1-b610e18cdd3c@jannau.net

To: Srinivas Kandagatla <srini@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0556d140170a..b4e5069d9e38 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1598,12 +1598,14 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void
 		*p = *b++ >> bit_offset;
 
 		/* setup rest of the bytes if any */
-		for (i = 1; i < cell->bytes; i++) {
+		for (i = 1; i < (cell->bytes - bytes_offset); i++) {
 			/* Get bits from next byte and shift them towards msb */
 			*p++ |= *b << (BITS_PER_BYTE - bit_offset);
 
 			*p = *b++ >> bit_offset;
 		}
+		/* point to end of the buffer unused bits will be cleared */
+		p = buf + cell->bytes - 1;
 	} else if (p != b) {
 		memmove(p, b, cell->bytes - bytes_offset);
 		p += cell->bytes - 1;

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20250901-nvmem-read-oob-bit-offset-dc1c2f39af6c

Best regards,
--  
Janne Grunau <j@jannau.net>

