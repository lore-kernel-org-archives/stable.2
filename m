Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584888;
	b=kcxJEWLfzd1/wy3cNYAG3rqksnZOSkJlwLf4kf7RTgeSWn9MjFUd7xTzsL9YL88QEf3a
	 U+u+jiL0NnNoCK5tqQwy+moIXDaN6nRulbW9HKiDZe8ieDZyElFcd48aF4T2JwcE17vuq
	 H0beteDxpiF2MzoXQcqWqgsgw7d8XCPI+Bl25LTI3cS0NUdba5pxVwddl+x5hgKzs8XcB
	 y21g7FRxqt5iaHQG/ydbycRbQopbTjf0bDHht/QGDrZtFYX+cz9MkdIt3PwXDq+Dyqr1t
	 pQzjaYlCC5moiBQ1ehu4uiJxGCmLycS7MfZ5kQuVlhfYxugvmSQfeJ+2hQ+TZRNJ9+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584888;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S9BWyTKFqPfO+V5O5DmNko7gL56NdP2ZVImcVs8PdHM=;
	b=ERr5Ee6O6jgstuhmGQMitXOZOtmFk2VXdeX3as4YFwGtWg5rpS+/HjMrjwQgAb10avBy
	 ORTaJMlfkV0Dw+riav+FWaUa/V2bkm2bI6cvvBibh+QS+1msDQds7JUnJjM8D1fdQa0kb
	 fP8rwatLn3akEWBnqzb05K0828s5mOSbMsTr9oTcTOYgEQIlyPYOCFTdySyfqRnyLbfJJ
	 pHexEU7ZqbrM40Gs+rmwWIqfnRI5fiMzzQLTcMCucfzKrhTyJQtXAO0r27D0cbFYNxv9z
	 V9Na4zbiFd3O1XDHPVfD0qDhdHJ3VlkxEjLTnRYOTclQK+BGKrBqvNBRCWD5JsXrf7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T/JlXOhy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B84606A31E;
	Wed, 21 Oct 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T/JlXOhy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0AE1F000C4;
	Wed, 21 Oct 2026 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584888;
	bh=S9BWyTKFqPfO+V5O5DmNko7gL56NdP2ZVImcVs8PdHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T/JlXOhyflSabvmEL56r3sUhB4uK5sNufsCIRff10Ag5oAF8zmifjnuMqLAJr6z6b
	 /mS/rYzI73s2mg6apIcpy8e+NvKKFoWY8UWfjneo/jTDls4XXRN0bsksAgiQc65UOq
	 HXENOy48cFMksJ76uiooVIrwpIIp6AriqxpEM3osFEEOtM76Lj54QaAd/RjmxW7OCo
	 4W/a2gmLfGOhl831PuTqwP1tVCHUMuX+QMQIbFW0GsOboRx/4acYpHJrpE6Za/VM9M
	 1f/yBpxVviKgJVRsDEsaEkk+4z2as9QlenEBfLdfedIY3muCl992hM64WBuIxPxMtd
	 1EJersBgGg9cQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ming Yu <tmyu0@nuvoton.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/28] mfd: nct6694: Do not resubmit interrupt URB on endpoint stall (-EPIPE)
Date: Wed, 21 Oct 2026 12:09:30 +0000
Message-ID: <20261021121245.3111563-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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

If the USB interrupt IN endpoint stalls (-EPIPE), usb_int_callback()
falls through to the default case and immediately resubmits the URB from
atomic completion context.  Because a stalled endpoint completes newly
submitted URBs immediately with -EPIPE, this triggers a tight infinite
resubmission loop.

Treat -EPIPE as a terminal URB status in usb_int_callback() alongside
the existing teardown status codes, matching other USB MFD drivers.

Fixes: 51dad33ede63 ("mfd: Add core driver for Nuvoton NCT6694")
Closes: https://sashiko.dev/#/bug/linux-9d8d1902-140d-4559-b604-76ba76e778a2
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/nct6694.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/nct6694.c b/drivers/mfd/nct6694.c
index e2957e587d1b..40a29f8e0ff6 100644
--- a/drivers/mfd/nct6694.c
+++ b/drivers/mfd/nct6694.c
@@ -201,6 +201,7 @@ static void usb_int_callback(struct urb *urb)
 		break;
 	case -ECONNRESET:
 	case -ENOENT:
+	case -EPIPE:
 	case -ESHUTDOWN:
 		return;
 	default:
-- 
2.56.0.218.g1ec904b173-goog

