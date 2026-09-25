Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0CC1DF736
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790295043; cv=none; b=PJOXfwyBBjUugMZQT0Y2vHPD6LaGJmtaiR8BPsRLYCcFfkPfSV9EzUx4wxH/UCVUBB3RG9fyFRwyeHvUweRLYRxIoqezlAMGvf6cTd26hMKZPh40Mv5sGsIB65FtKd4bJ5TEQJa9+pJBDYFKoCPUcVV5zLwP8VRGP9p6n8o8twk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790295043; c=relaxed/simple;
	bh=/cxIRdqKu8S8t3VbgiqidVXFl1GWt0Sm4m+5jxGzei8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZDDEe5VS3G7b2iW3oLyJoeB/9nWAJGpRoqZOp1LfhDGFBu14Ve+HEUv3odd/DFWSBZ+kVQcxlsnZVGfBqLF3AyBtQvKi7oPtxu8izMDS7RBhNkgK+c1YMuapqt3ucEiGN8IRxM1dv0slLWL/GDYsAuINZ7Oegtvd4bNeu/GlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=bDycZj2a; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="bDycZj2a"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d07so341907c88.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790295041; x=1790899841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YlaWOdm+KrKq03MPPT9DB6CjgbrirrQUyiKzlIWUgEo=;
        b=bDycZj2a3Klsn4a8TKNizRgS8FI+b6kIZmFjvP3/TJY0TKomOIvmRC+nvM05qjfTbR
         R8NuQdJhcPiZCpDS2Eg0gU/o4Y4G8mQLUHVrI50yLSolWJradMvbHoGkmZwGEa6Fq5r8
         RhKwiNbd9xHWNvw3pIvkuP7Q4HJFTXC8vqibSyEpVChYE11JjRJa6PJ3eU0hoq0rfiUu
         V1XvashMRIdK0XfItuF/6Jp8pSaYJiUVyP9sZ2Jov+jIvFRMxtMoJYyOOG819+0u+JNy
         FfB053A8/D0rG7dPPdOL4QP7p8maZrf9JloX7A3TxE6mx4NCqooBhpzC2hH6mYlE0oTJ
         HLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790295041; x=1790899841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YlaWOdm+KrKq03MPPT9DB6CjgbrirrQUyiKzlIWUgEo=;
        b=okqyaep4oQuBKvLK8nHXiK+f7YuW766Sbm2hG7Ap3BjVsQp0vkMcBKidXgcKZJSvTF
         ii8JGRl7X2msgIEckCkub1XLhcsf8Tys2KJVGOnqBTW5bIY1QIAdkCqDHRPoce2UgoOW
         LqZ9hTc0tTru7lt/lNmeRT8hd7Lfi+8gI+Qzz5SUzfn2R7tdDtR/+A5GRoE6bhbFkgdA
         DFC9kgQA/KMI72C4KZJzc5uBU5PMb+uE7V8verGuWV+m0s/xwXukJ7U53WRQ6CAAvuav
         F8WHcDZkIWBVBH9loi8GRXDGzZk/nzKkfEJEv0Vj+7kRMWxBpLkAHkCyeEesM9sVBemt
         K4Cg==
X-Forwarded-Encrypted: i=1; AKwUvBw0gv1Ub4wlBHlf/IjCkWctGEVxDF3m5OjA+TgRwdU6rG0mC79sl4rqd9ktitscPm75odJKCcI=@vger.kernel.org
X-Gm-Message-State: AFuF++lFCKg47tnx+97OWq9AEifoFrlnIF815OolXYbwN4HgBTggvMQ6
	+Z4dJQnoLzeEVGihPbPh3ThGBIj7FtOmnoshgqzGYHTKHN9FlLMGsSCjZu6W8Ownc/I=
X-Gm-Gg: AYBFou2RdYQn0TNt9b0La51VcL/+pGvHz/REm55qosEOCULqBZ/oH9YXc9eji70E4+w
	P6OvmgxxxszuXKCdBebHclElO/QH5Xr3gog1vfpcHg8eqyKP57oUSbzaDfCcUAurEwhvDeN/YFN
	KPHbeEUEjRjdkuL3KZtIoM/aJVdEo+je5X2NauENUE2DEnPxbKpP+kZhndR+K0vZVYjG50j0gAb
	vQ4bl1daJp14dLboqZk7ncpObzqCiLp35ZnprFCGnOzJbvftWqklensN4nfOvcSx8e7F6QENrEI
	vKq3KFqU7bhR1hFsCQJDHBBSIwIgEZWJZUksNXDcyK1ZdvkiZmUvg7ggqgbIz9fhyySwFzAT+rX
	b5SMOzdMpzFth2BzTir6iP8mtUMRDnu+CTcdPik0GDmwgUl4csSGtZ143M9j7xHh8etFKoYm2KV
	tC4LgoDTG3N0DxiPmckg+pdvITJkM/Yi41yjuJRiW7JPjgesN8SSQIrle7jkDW0q+sTpdBcsz1c
	g==
X-Received: by 2002:a05:693c:87c3:10b0:33b:c478:a545 with SMTP id 5a478bee46e88-34002be4604mr2878731eec.8.1790295041240;
        Thu, 24 Sep 2026 17:10:41 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145632298sm1787647eec.22.2026.09.24.17.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:10:40 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Thu, 24 Sep 2026 17:10:36 -0700
Subject: [PATCH v7 2/3] i2c: xiic: defer RX_FULL until all trailing bytes
 are in FIFO
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-i2c-xiic-v7-2-df7e752332ef@nexthop.ai>
References: <20260924-i2c-xiic-v7-0-df7e752332ef@nexthop.ai>
In-Reply-To: <20260924-i2c-xiic-v7-0-df7e752332ef@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Raviteja Narayanam <raviteja.narayanam@xilinx.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790295038; l=2278;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=/cxIRdqKu8S8t3VbgiqidVXFl1GWt0Sm4m+5jxGzei8=;
 b=a+pbWTcLJPiSEUJjIdHnPTS8tKRM1v4Eldm+PcCmLAtpHVPSWyDvgonMUJh9zoSaSWFyjR0YG
 CO5ORipMLjTAYdDSZY8+8zBXwdw4DNgwyluzbLCy8U3+O7iIeZNMm8L
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

For the normal path of xiic_smbus_block_read_setup() -- the trailing
bytes all fit in one Rx FIFO fill -- RFD was programmed two below the
byte count, which fires the RX_FULL interrupt while the last byte is
still in flight. xiic_read_rx() then lands in its bytes_rem == 1 branch
and sets NACK on a byte still on the wire, truncating the read.

Without PEC this is harmless: the truncated byte is the dummy one the
caller never looks at. With PEC enabled it is the PEC byte itself, and
i2c_smbus_check_pec() fails the transfer with -EBADMSG.

Raise the threshold by one so RX_FULL fires only once every remaining
byte is already buffered. That routes the drain through
xiic_read_rx()'s bytes_rem == 0 path, which reads everything out and
emits the stop cleanly. The only change for the non-PEC case is that
the controller waits one extra byte-time before servicing the
interrupt.

rfd_set stays inside the 4 bits of XIIC_RFD_REG_OFFSET: this branch is
only reached when rxmsg_len + pec_len <= IIC_RX_FIFO_DEPTH, so the
value is at most IIC_RX_FIFO_DEPTH - 1.

Fixes: e4c1ff772e1a ("i2c: xiic: Add smbus_block_read functionality")
Cc: stable@vger.kernel.org
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 0777de45bdf4..5cd737c7608f 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -569,11 +569,11 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
 		} else {
 			/*
-			 * All trailing bytes fit in the Rx FIFO. The widened
-			 * condition above guarantees rxmsg_len + pec_len >= 2,
-			 * so this cannot underflow.
+			 * All trailing bytes fit in the Rx FIFO. Defer RX_FULL
+			 * until every one of them is buffered, so the drain
+			 * takes xiic_read_rx()'s bytes_rem == 0 path.
 			 */
-			rfd_set = rxmsg_len + pec_len - 2;
+			rfd_set = rxmsg_len + pec_len - 1;
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);

-- 
2.54.0

