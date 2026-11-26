Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709217;
	b=3OfazvCHDKhwyNpTQxabZWJFbgURpy5qeXGgO5pHjWc08QVeIhBoxKxP+AIvxZt/8rvX
	 cwptA8tQx27Vzhjno6TDxr30wQYJPW7c4Y4zbbJgTRZDG8NMebrOo01PDvsvt0K7auoG6
	 9kzRK3h7/xiMbuYFZgRt9JK02a5FNRxpd7CaFXLyzQ1gyrTic58vKHyKWK+TjJ0RK39WV
	 RnsdPSlgZijhB61Hvlwbw7BZfvJ9QoOSOomjTV+RidOIqruYptpILLBTf5cu9L8jW0zXk
	 G9ZXJ3q8gNb966YTgpEYJXrxJKQk1qed7VhG6yVTG9SCkEYf7QBh9Vc6IcI3pO/4gSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709217;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3RJgB94Jo0AzGih3CVMbc45s5hA2HCsrUoRbzlQkWRE=;
	b=zBRRMgaKjkKIZqVd8HScPbRA5GTHHOVCW9Xx1V7RkxOKvZGjHzLWkJNPlW8U7pFXSNK/
	 UEBMBfwUwz2wNxuT5d55wdL/+cckX/ILdpvnJre5q4XXhmR9RyIA5ON5W8b1YIZDWBdQe
	 82FCXrwNQznBlSvAIMfi0kdLciyfb0lGK3d9js/tpl6loG/s7bqz3F4EygUlcyGIxFnXa
	 lxilmEWzRoLPwrlIVOlfZMLkHxbOyBoO/gEdOn4faJ8IBvb82+BUrZ+sKLA2wwd5LT36u
	 8anurmoWKppmue0P3I5lpbJp3dKUKKM1JWLWz5V9lYo0kSW3BlLjETFnRM7dxRZ67oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZU69k1w6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42E606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZU69k1w6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490121F000C6;
	Thu, 26 Nov 2026 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709217;
	bh=3RJgB94Jo0AzGih3CVMbc45s5hA2HCsrUoRbzlQkWRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZU69k1w6R9ZHReaTZA6wCUPC3ArzsTUHIqyfC4XBdO9Z1EeRBik0kJz3PSev7vwK0
	 Vunhcgzx+Xk6jndmdFRsDSOptfqOIJNsCIo8BMRINk7/354r4UWVUAtdkd5+vvPEGQ
	 MIQHqMp0yo/ewWKMHTTNZSTcY86fuFjWAGGmJy1dGz0HzDjeCB6WOYCWjUBbjY3PV6
	 xzs6eKP4yuRPnTuBuZHgHNgzMLBDARalLA4YbwAfhIU8PTEBigw7TwWvnX4MofInVh
	 9QUrgHY+WgXM3KdZ8q4ibXn+HENbIL9jYCNSHe9BhUh1YrxAzQrHaKdZlWLUv257Y7
	 8td3nN6toN21w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	stable <stable@kernel.org>,
	Selvarasu Ganesan <selvarasu.g@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] usb: dwc3: gadget: Track a timed out End Transfer
Date: Thu, 26 Nov 2026 11:06:53 -0500
Message-ID: <20261126160644.2531838-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126160644.2531838-1-sashal@kernel.org>
References: <2026112521-mating-confiding-a0fa@gregkh>
 <20261126160644.2531838-1-sashal@kernel.org>
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

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit af91c6322e633504aa45de278f5d520f39d127be ]

If an End Transfer command with CMDIOC times out, the driver clears the
resource index but keeps DWC3_EP_TRANSFER_STARTED without setting
DWC3_EP_END_TRANSFER_PENDING. The command is still outstanding, but a
later stop issues another End Transfer with resource index 0, and the
next Start Transfer fails with "No Resource".

Mark the timed out End Transfer as pending so that no other command is
issued to the endpoint until it completes. For any other failure, there
is no outstanding command, so clear DWC3_EP_TRANSFER_STARTED.

Fixes: e192cc7b5239 ("usb: dwc3: gadget: move cmd_endtransfer to extra function")
Cc: stable <stable@kernel.org>
Reported-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Closes: https://lore.kernel.org/linux-usb/3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/5815c41a7e7923edb114741f29697cf0161f523c.1792542945.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3ee4812bebff5..e5ae26cc85b90 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1481,9 +1481,9 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	if (!interrupt)
+	if (!interrupt || (ret && ret != -ETIMEDOUT))
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else if (!ret)
+	else
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 
 	return ret;
-- 
2.53.0

