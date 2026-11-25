Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608396;
	b=PDTGlRMFtWnT63GtFojgrcrqlsKWwFgWMCxIv76sQlEsZXjZv3H/iUDF7wNWUO8B1Xqh
	 YTQ6neGbb76RoEkUuUTv/Ak9rwJoJH5UEc1vAZqDbKGpK3wF1XLfTNQnAt7x4f/CWpdaK
	 fY8i/w0GprfLde9pc0tsB6T7/ZEp+lSctAAso/GcUlQd55Mz29//kY8t+RnX0PQM3VYFQ
	 Pt5G12oH4GbyO2xnI139ohEKag2SFAEijKXdI9zBK7GDuRdgQvgMuOZZIv1dsGAFN97yG
	 RJKGnA4cJrkpo4hxozGtfknAqVtedPnO1g/CX3eIut5ScDUMXjKZQJhbmF0LHtWT7/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608396;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JrxkxfDWzf0wglrzMOQo8xtVR9xtJ0N3v+1HQmjIcYU=;
	b=TaxGeFsPyovLMQBERHHNxuFNkgvYdagEWVC2efwT5oC80tiDQyO05i5QTo3f14il25ui
	 Fp5HIh+1whnvlJPS/DXGc4VLjRc95+UfQkIAJsSGM5n2bJvMNEXq4W/PgATm3Wji/IJaK
	 +ciu2J41V0zmeB7ifS9C+Nt6cgbK1tpw1fanw/sG2YKPF01tU7NXEW7f2MdDy2dNo3JJG
	 jN0yATx9Z+fhnYRhIUNYzWlWnP/dMi2Cv4Dwt1f2lq7gt+Zmz+7y00sPxzXF4iyyTgXHv
	 S6wLqV4HLO8aDCQjLFREQ9ESKH4b+w74rgUHVowL8vHp4+wj8mjrJJiqekS3vGSsCrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OK1Fh52f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC933606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OK1Fh52f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA8A1F000CA;
	Wed, 25 Nov 2026 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608396;
	bh=JrxkxfDWzf0wglrzMOQo8xtVR9xtJ0N3v+1HQmjIcYU=;
	h=Subject:To:Cc:From:Date;
	b=OK1Fh52fXsI/AmgaTLW0jUJIcdbwK97rBEWLwyLvI+o0Ay519Lb7V/p5PW+M0+CFG
	 F9Vv8HMFIIuJoCRrWmRXsggIRTYA8YDZos2a2a84fgKessnGt1/7JgNuxZbsUjhUwY
	 0z04kL9P5HzLn/gjUYIQpZqza7EpeZBAOXBxPOew=
Subject: FAILED: patch "[PATCH] usb: gadget: f_ncm: restart the TX timer if the TX freelist" failed to apply to 5.10-stable tree
To: cosmin-gabriel.tanislav.xa@renesas.com,gregkh@linuxfoundation.org,hiago.franco@toradex.com,leonardo.costa@toradex.com,stable@kernel.org,tvlad744@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:35:52 +0100
Message-ID: <2026112552-crinkle-hurling-1987@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 78585f90feb3bbaf3b1c642294c8c47e451dc3cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112552-crinkle-hurling-1987@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 78585f90feb3bbaf3b1c642294c8c47e451dc3cf Mon Sep 17 00:00:00 2001
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Date: Mon, 17 Aug 2026 22:26:38 +0300
Subject: [PATCH] usb: gadget: f_ncm: restart the TX timer if the TX freelist
 is empty

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

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 500c9c19c78b..ab6da3ef8783 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1148,6 +1148,7 @@ static enum hrtimer_restart ncm_tx_timeout(struct hrtimer *data)
 {
 	struct f_ncm *ncm = container_of(data, struct f_ncm, task_timer);
 	struct net_device *netdev = READ_ONCE(ncm->netdev);
+	netdev_tx_t ret;
 
 	if (netdev) {
 		/* XXX This allowance of a NULL skb argument to ndo_start_xmit
@@ -1158,7 +1159,11 @@ static enum hrtimer_restart ncm_tx_timeout(struct hrtimer *data)
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

