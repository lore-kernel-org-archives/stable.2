Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707107;
	b=DwAjQjgg9t3p1qoTeuGQ/BhNSmehPKC+00P9r1jvztTZaHg4i5Me+JIxbk3idAZRUl0o
	 G+4oVzbkhqqr0SgZsyLmeLl67igQlFeAQ3cR/P4QiiF3VYy1dYruUedqsDpa9SuY423n5
	 4FXr/LVZnSNszPvQMK0A+LICf90KLHnglO1SPsIuJashDvcBzrGg7k/nNxjcmVxz+PqEG
	 7wkxs2Hpi9vaqnVW/zmBNgKwU6+qQAI5HPJGYoIj+GSRztd6PPmUJhV7mDyY0Oad4NdyQ
	 S2DaGKjpt/lP9e0O1J7RAYZ0J+zyhRsdA8Zu981psw5CYVftIRLZlMCnq738hC+1QDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707107;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WGagtH9Op0eS4oJh58kBxn/t+ZB2KEi6T7OpdXTGLVQ=;
	b=vNeGDt2WKYHwBmTZLkU5Hnmha0zck+vaDWwBQ6j1E5YRi0UNONObQS2rZgpAGBlTHH3e
	 leKNRgfNgHVP1EYk+izxUO/FJg5A1K0YdsDGGUKePtcHSi9JwWwZDxgqvzGT8uy7Vy6rq
	 iYFtqlt4EtKFZ89VLIPyHrqTGPT0bKut+K9QTjw/49zQoC4DcYQVCqLCUrPBDKPJCW7CL
	 XDO2+4d6D6O7xIYTmsgmFBG96lKP5FoR+YX01R8dn+qHf1upYRNunpNmps65+Wo2N/ZNV
	 W9g21PjcK/x6MSN/XE0FQAZk6j9DAtI1OwYFFtUhIPvXkF945Qxtl/3us0Co1VgkSdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3yWNQDz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBD606A69B
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3yWNQDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441391F00A36;
	Thu, 26 Nov 2026 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707107;
	bh=WGagtH9Op0eS4oJh58kBxn/t+ZB2KEi6T7OpdXTGLVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3yWNQDzZU6rNiBYbUe9jsgESOgY56A9dBlxVD0qBV2Vb6xBRbMmia7hvvKhvQAjv
	 gHtgTsZQXVMvkmDshuwAmBwb0l6YxoXwRzcEspfXQL+2mvthnPK8iwfXMk+TqUAkMJ
	 bSYTaaW+zp7UPXWFYuukDEYmhI+uWENYUkdMPlSnNoQ5vnVhM59Og+DbJKgYJSUSLm
	 GyqRZXRYvOKbV62ZbRMKsiki+MjByCVlFHYi7cCeLLdKEW++R5nCwgL2k0kgE5BcWS
	 0JQx1KB4Euxrb8lKkLReikj141lpMGEhIHu5XLSYZszlOS30jKW4FU/XpI11li42zd
	 pM7mJwLqvPGhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	stable <stable@kernel.org>,
	Vladyslav Tymoshchuk <tvlad744@gmail.com>,
	Leonardo Costa <leonardo.costa@toradex.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] usb: gadget: f_ncm: restart the TX timer if the TX freelist is empty
Date: Thu, 26 Nov 2026 10:31:41 -0500
Message-ID: <20261126153132.2453772-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126153132.2453772-1-sashal@kernel.org>
References: <2026112552-crinkle-hurling-1987@gregkh>
 <20261126153132.2453772-1-sashal@kernel.org>
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

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

[ Upstream commit 78585f90feb3bbaf3b1c642294c8c47e451dc3cf ]

ncm_wrap_ntb() aggregates datagrams into a pending NTB, which is sent
either when it becomes full, or after 300us since the NTB was started,
using ndo_start_xmit() (eth_start_xmit()).

ndo_start_xmit() returns NETDEV_TX_BUSY when the TX freelist is empty.

For regular packets this is fine since the networking core will requeue
them, but for timer-flushed packets there is no logic to handle this
situation, and HRTIMER_NORESTART is returned from ncm_tx_timeout()
without checking eth_start_xmit()'s return value.

Under sustained TX saturation the request freelist is empty most of the
time. Since the timer is never restarted, small packets keep getting
accumulated into the NTB, until either TX_MAX_NUM_DPE packets are stored
or NTB_DEFAULT_IN_SIZE is reached, which is an unknown amount of time.

Check the return value of ndo_start_xmit() and restart the timer after
another 300us.

Cc: stable <stable@kernel.org>
Fixes: 6d3865f9d41f ("usb: gadget: NCM: Add transmit multi-frame.")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Tested-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Reported-by: Hiago De Franco <hiago.franco@toradex.com>
Closes: https://lore.kernel.org/all/20231204183751.64202-1-hiagofranco@gmail.com/
Link: https://patch.msgid.link/20260817192638.437798-1-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_ncm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 630b131422022..acdb6522dc2e7 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1157,6 +1157,7 @@ static enum hrtimer_restart ncm_tx_timeout(struct hrtimer *data)
 {
 	struct f_ncm *ncm = container_of(data, struct f_ncm, task_timer);
 	struct net_device *netdev = READ_ONCE(ncm->netdev);
+	netdev_tx_t ret;
 
 	/* Only send if data is available. */
 	if (netdev && ncm->skb_tx_data) {
@@ -1168,7 +1169,11 @@ static enum hrtimer_restart ncm_tx_timeout(struct hrtimer *data)
 		 *
 		 * This will call directly into u_ether's eth_start_xmit()
 		 */
-		netdev->netdev_ops->ndo_start_xmit(NULL, netdev);
+		ret = netdev->netdev_ops->ndo_start_xmit(NULL, netdev);
+		if (ret == NETDEV_TX_BUSY) {
+			hrtimer_forward_now(data, TX_TIMEOUT_NSECS);
+			return HRTIMER_RESTART;
+		}
 	}
 	return HRTIMER_NORESTART;
 }
-- 
2.53.0

