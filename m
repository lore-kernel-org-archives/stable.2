Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793722251;
	b=Sl4o6LQAyy3g7sw1ub7umu6Yy/pTbTDSk3Tt66vI1On2PfzrJz9o2oRVxeblMovUkY1x
	 /lq9/yJMMhNSS2zaMsQA2/XPyOnSiDjFLEzBbLbJ/amIzI4QnQ9f4tnR0uyYVVP5oxjB8
	 9e1X6ettiMmmAjAt+gJnkiKl2cGHyLcMJA/l+GlrTfjbGtDkJtr6hppzypzjTIV0Iheaz
	 LRwuORgBYkBB94oYQFrl0DSL8DeIzd3l9Qx3/SxHSlQ/fVbA3EGRYxxTwfVBlaVDEU5HN
	 NGgVQAyKebRuCGCqmxJXpkX6JQE/2E0tDICyRN30V+nYCr44Tt+w1VRhA3NMG7N4y2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722251;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Z2YKI7+H/OdNdwa8asA/bP44EVKNEx8M8jYKzAuCkW8=;
	b=bFrG+Nx1Z6inBL3iYUM9zA5maeUwGcPrY0rjoqZOhUaRm11rMPtQCkPneHyXIWBMO1Hg
	 C35ZzaST1eAWxbDzY0FpTToF32wWp/jGpC53gZTQW1b2C/teeTMsssqr1sDDdubKhJt9b
	 PjfiVN+omv3pt0+3wQCE/6aWVLp/8NWZwEyISJSAyOgXjYdmsj5xfZMxOVzczHr4PPe0x
	 SzC6vmTtOp3BE75X5PQtj9DhbOiUqKajjdh8PzXf0ToNOhXCtkvMd1vuGRCPix8t04ZgF
	 YZthJyHcrJBZBW26jupOQsKtwQBr7PskQ4ZPUX6KQ/B9d/W7TGHrBUgi4H4sZOIZOUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rlvw6MLE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97471606A324;
	Tue,  3 Nov 2026 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rlvw6MLE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793722251;
	b=d5p+tFxFfMQipHvXU++hUbz6jW9ruwZRNLEaQGljftS2sA6AGOcloILnzNYswgT2qPre
	 EUQ0L/WUK6qmZf+3gE7q/HuwXE2gikfVad1wtGmgwsNWpDqH8g+UJAHAwPskogwxcMEJc
	 oVT6FyeEL+aEU5YSOMr0YDPQ5e1uE6Zz/Nsqk5LPHHK1YUGWsM+pHdbMu+A7vVLmL8HO5
	 bnSZxmTkjsNMlWS734pBF8T0pUzO2LJdti9JhRncCwMfyprKaxqDdRzoY3DcFy5+tBW/8
	 PIOqShlKyFulsGskFVeH+OLYti5DzXdi//jotNVvh8PT6QNwEBi2wRkb3Ol/I2CHK+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722251;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Z2YKI7+H/OdNdwa8asA/bP44EVKNEx8M8jYKzAuCkW8=;
	b=Az2O+ImfHPiShiPzcUx7VJWuGZkITCbvm2UvSC4Ke5RolXO9v53bqb5hu+IqugMMyS1Z
	 /uGHpldsD4GWg21ARlQ5ym7As+OCIQoXq/Qxl+iy19eWCwS7om3z9rGLmMwZEtEvLXbwY
	 RxRHlcgP/hQpp+lSun8T/oh2uFFrDmgp+K4MOsUJLIl4wZ3O8nzxo/J4KM+1quuPanKns
	 y0ePyP97ROYeEuMcKcUL/pel56xaOCGgvPEzxlYUaDi2qYBuZRT/6Kt4LoOVKDCJlhUBS
	 d89J3X6uM+/C7K1N5jeVeoxeVIJMopNvZ6rhPCqI2eou9cquISfBzsONx2gafGHnFiQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F21A81F000C1;
	Tue,  3 Nov 2026 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722251;
	bh=Z2YKI7+H/OdNdwa8asA/bP44EVKNEx8M8jYKzAuCkW8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Rlvw6MLEF5DHL28ACzbGZMUYLtMfDqUpwjVy6G1hvuzjGJ8lkx5dc99jxNT8j+8R2
	 q+RlqZ8FAdBFRq1Kdc8VSxGwkGPe+JErnhMhUmQGHLAJgGfaKd7oxE4CZVd12LnTPx
	 z9fIW43cuzhCbbUxpOtYbsrAFxmhcETgkn2EKAUR6eu3tNDgHtDLCSLjduPxIfTvrq
	 03x95KVE+/t5UHIMixG7y4Kadt1A4OoazgVvNLWxyVCoBmrBE7cdjBn2zxdZuOKzAj
	 PE+w2zPLHFAuczRNlcRnAvgB6QhbYTx1CV2wz5GcS126sb2wJhcxL5saxEqMUrpsbI
	 B9KxDyFfpH5lQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6B789469F6;
	Tue,  3 Nov 2026 16:10:50 +0000 (UTC)
From: =?utf-8?q?Stanis=C5=82aw_Titenko_via_B4_Relay?= <devnull+kernel.resetko.pl@kernel.org>
Subject: [PATCH v2 0/2] usb: typec: ucsi: acpi: Zero version quirk for
 Lenovo ThinkPad T14 Gen 2a
Date: Tue, 03 Nov 2026 17:10:19 +0100
Message-Id: <20261103-ucsi-lenovo-t14g2a-v2-0-e85c659b56a2@resetko.pl>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBREr0L+2hpalKIr72FY1PILX0lL2tJoC
 He34N7M6iUzbxYI6AkDXIsFPCYK5GwGcShAD8r2yKjLDKIUNS8rzmYdiI1oXXIs8lMvFFOdQtk
 Zqc2lgTycPBp679J7++MwP56o42baGgOF6Pxnf0186/09SJzlNJU8c6wrXYpbNmJ8ueM0Qruu6
 xei3gP8xwAAAA==
X-Change-ID: 20261031-ucsi-lenovo-t14g2a-adae7df7cf98
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?utf-8?q?Stanis=C5=82aw_Titenko?= <kernel@resetko.pl>, 
 stable@vger.kernel.org, Daniel Dev <daniel.dev@noex.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793722249; l=1240;
 i=kernel@resetko.pl; s=20261031; h=from:subject:message-id;
 bh=p//gIxG0/4XKWUIu5qLUQ3pQMFy2I5L0ehYWw5C0oIU=;
 b=ryKdmPp1FcjTXd/ovnXlgELckP5xFn69Zq5k4covVsZxy7P2b5G5oKryYK2v4unLl8GGrCQ+s
 PchvYToK+ckAffIKzuAD4AH+zqBeWCP+17CGYPk42tDs9BWlUBWEOtx
X-Developer-Key: i=kernel@resetko.pl; a=ed25519;
 pk=xMhqzbyPNWfeOgdmzSHsSlr5qjH779F5SD6BBHXixlY=
X-Endpoint-Received: by B4 Relay for kernel@resetko.pl/20261031 with
 auth_id=1372
X-Original-From: =?utf-8?q?Stanis=C5=82aw_Titenko?= <kernel@resetko.pl>
Reply-To: kernel@resetko.pl

The ThinkPad T14 Gen 2a firmware leaves the UCSI VERSION field at zero,
so ucsi_acpi does not register the Type-C ports. Mark Pearson is asking
Lenovo's firmware team to look at it; this quirk is the fallback in case
a firmware fix is not possible.

Patch 1 renames the existing Acer quirk to a neutral name, patch 2 uses
it for the ThinkPad T14 Gen 2a.

Signed-off-by: Stanisław Titenko <kernel@resetko.pl>
---
Changes in v2:
- Reuse the Acer zero version quirk instead of a new Lenovo copy, so the
  assumed version is now 1.2 instead of 1.0 (Mark Pearson).
- Match on DMI_BOARD_NAME 20XK and 20XL instead of the product version
  string (Mark Pearson).
- Link to v1: https://patch.msgid.link/20261031-ucsi-lenovo-t14g2a-v1-1-183751e63c02@resetko.pl

---
Stanisław Titenko (2):
      usb: typec: ucsi: acpi: Rename the Acer zero version quirk
      usb: typec: ucsi: acpi: Assume UCSI 1.2 on Lenovo ThinkPad T14 Gen 2a

 drivers/usb/typec/ucsi/ucsi_acpi.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)
---
base-commit: e9954f3fbddd25e1a01b7e5a0b72fb8b564204e0
change-id: 20261031-ucsi-lenovo-t14g2a-adae7df7cf98

Best regards,
--  
Stanisław Titenko <kernel@resetko.pl>


