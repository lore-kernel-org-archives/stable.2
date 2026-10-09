Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764A25DB0D
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791507718; cv=none; b=D6VcZm6nKdo6je7kwg5ObLAOucUZsD55SdXaeUoD5P6aCeZMriYtT1R0ys62zUj+77XlixUJy3BlcgRX6xbTVpo0lgpA+qQlhLnDG3DeY8IXXLF1XtY7kBcWY4bTrXXnFqmJuVDuU7NVqGikCj6vfFcDLBxuQOTbrWTpsIWCXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791507718; c=relaxed/simple;
	bh=VvsfpHaXhPNuOESsbmKbjgRvCxu9b+24W1f2Ek0pgic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aICqHEb/5VHi7qIszee0vLWmmI6ob49kCL/MUPp8TgoiOIpXnoN8rPLJvBZeKbdyKVvoiyrUiBN9YRYrdlCU8LoPWB6s6/TGxfnF+srKqQVBJ4tEforHkJdNH8iDZbAa2KBjQOsxE0VxjQm48KyWPcTqzjoacGxYsnfCisLTdXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=JxjhGPKE; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="JxjhGPKE"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3115c4451c8so5013627eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1791507716; x=1792112516; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cfdw+audQWp9HNvQGo23exvCo4IIEY6hjGNhPZtb1Is=;
        b=JxjhGPKEzNITA7xktGvNciFvzlH0nUKz8Ie3c5F5t0zdMip+KWv9upe55rWVDqmQqv
         1TCKYVdjMQi+qBMhyDoH+7FF/Tvp26+/FsJGVRtrlLMszPhKpaayoaWF0NKXY3l0xCc0
         GtfbD4BNxk14rBPL6g1/7l9TfZS3L49jUAs3V6+yE8KCIxKVqGp67XelC8uPEm1LBv5e
         g5M4oP+bbTrBLE5OY7n5yBA7lM6tip/YBp2kH1c3GfC+DfYbNpezupNb/Qj87cgFovo2
         tVzQMES42u/Jt6RVqLTuJ5InwwcWhIkQ6WYJhbcOFEo4ok2SephM2KwrBvjmjg1iXkJG
         MlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791507716; x=1792112516;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cfdw+audQWp9HNvQGo23exvCo4IIEY6hjGNhPZtb1Is=;
        b=oUv/IvW5vupwum54wugRZqfGGiFYx6z5pyTgA1ifTs2BbQVIHA5v2XPTwwVTW2LWPJ
         PsjR6mK0AaKkurGkn6UNICQI/81eHigFXHZXvGY+cibFhHflhqzk0GAivutRZOhCeD+r
         r8RFj4im7QdOzsP3C2p0MWt+PXwUgTojxeMXsk4y5uH1/gIWWSYivsRRE/pV9RijqpgZ
         plQFXcMOvizI2FcNZQVNH4ZFS8uO30R1VAjSNxy7MpKvJTsOsxCHF2V/K8UOeOK2W2lz
         eSVp5If8D7M51fdvc4v9Ms2X9EXy9Gti/Moq+6qDscs590wvSr7Nph8/wmfpSU2Lo2K8
         F31g==
X-Forwarded-Encrypted: i=1; AKwUvBwqUG/11eAIeR7PifzoX9e2PbzoY/Xck8Rm43Zim2HiIimPM16URIEGsPvUAoVmdXks2uFHiUM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkSalt7g7TucQGBUZviOaBwQiji9wECYcDz6qskyrGfmKSkALV
	k9LZvr2TzIajFR2CMIqMAkfxy7k+onjp3o/ZgscYahBsxjY8z4D0SDLoF5HqufF82g4=
X-Gm-Gg: AYBFou2tH/tX4zcMsv3wrZ/WNYDSBMCZkZiVQpSKxpVzP0gJKzX3zBb+4xLAuUUAsFT
	Psl8jnW4wx0Zc8EmwrkotZKPH8eIh6xhlBIR2drezyTT3Ui/QGUmChgPtuSCMOa4wD3oWmtSaVz
	t5q5bPLE4yUvzOUUD4EorOyP0j0Tk4vnXZpTEmxAJTb2PefdOyQaH7oB6Y/Xc/iIXP1jouP56uw
	Imm6qKJTFJZH1boOl9Kjx0VgtV/Thg/CDx2eMSrx2jzmWAErkQbKGgAecQYFTfpnosYfVLmPNmS
	vURD6I5tsqVQPoKeo8E51PBVfjPPhJgb1xRbWsqVvNES+yfm9lx/hbUWReBaz9C+j4/KcARU7NN
	RmNNZDMCWgCZVF/DraUeODJ+YGWX4rVd8GIxrV77WkfWloDFYIseu/cXLG05E03CVEfkjkv/8GX
	F9AIB+ktqq5S/rfIyrfgqApY6Wzt0jnyfpSHirCjWOqNRhC+vUxJblWFvNUhTzThyrvuGiVO4oV
	w==
X-Received: by 2002:a05:7301:71a4:b0:351:8d12:8d51 with SMTP id 5a478bee46e88-3537e029678mr656518eec.12.1791507716097;
        Thu, 08 Oct 2026 18:01:56 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cad9e53sm1828189eec.22.2026.10.08.18.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:01:54 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Thu, 08 Oct 2026 18:01:51 -0700
Subject: [PATCH v2] Revert "i2c: xiic: defer RX_FULL until all trailing
 bytes are in FIFO"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-i2c-xiic-block-read-nack-v2-1-76735ed0b0bf@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBREf4V07TW0CBRX/odh0cdFrpqWtEgwh
 H+3YFy6m5PMzFlYxEAY2TlbWMCJInmXQBwyZnrlbghkEzORi4rneQ0kDMxEBvTTmwcEVBacSsk
 KXRelVtbagqX5ELCjeb++tl+OL31HM25/W6OnOPrw3t0T33o/jfyvmThwaE5SCtVVWDby4nAee
 z8cFbF2XdcPj+4utNMAAAA=
X-Change-ID: 20261007-i2c-xiic-block-read-nack-d2b735baddd3
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Siddarth Chilukuri <siddarth@nexthop.ai>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791507714; l=6106;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=VvsfpHaXhPNuOESsbmKbjgRvCxu9b+24W1f2Ek0pgic=;
 b=/KyL2DEQwNeonF4R2JIRTXoPa/R37jOZKzBl58ZI/KbkjAxzRoUZW15Fu1AHYWej2PQxpNhaU
 /VCjW/w3r/xB4GHtakMz3rYqKCPkhGfVPvwld0UWk/LLDV0xLnscUNd
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

This reverts commit e6fe3ea04f0113fe4d47c03d76e03805a4768ca7.

That commit raised the Rx FIFO threshold for an SMBus block read whose
trailing bytes fit in the FIFO, on the grounds that firing RX_FULL with
the last byte still in flight made xiic_read_rx() NACK, and so truncate,
that byte. NACKing the last byte does not truncate it: it is how a
master ends a read. The byte is still clocked in and is drained on the
bytes_rem == 0 path that follows, which also issues the STOP.

What the higher threshold does instead is skip the bytes_rem == 1
branch, the only place that sets NO_ACK, so every trailing byte is now
ACKed. Having had its last byte ACKed, the target goes on to drive the
next one, and the STOP that follows lands in the middle of it.

Some targets ride this out; others are left wedged until the next
transactions clock them free. A TDK FS1412 fails the two transfers that
follow any block read, so it never probes: pmbus reads MFR_ID as a block
and then VOUT_MODE as a byte. A Renesas RAA228246 and one RAA228244 on
the same controller fail the plain block read itself and the byte read
after it.

With commit b7e6df2f52ed ("i2c: xiic: preserve PEC byte length in SMBus
block read setup") and commit 840d8acc8792 ("i2c: xiic: don't clobber
msg->len to signal block-read completion") in place, PEC block reads
pass at the original threshold. The PEC failures the reverted commit
attributed to the threshold came from the bugs those two fix; all three
were developed together against an ADM1266, which rides out the extra
ACK, so the regression did not show.

Twenty rounds per device of a block read and a PEC block read of MFR_ID,
each followed by a byte read:

               before                      after
            block  PEC   byte after     block  PEC   byte after
  FS1412    20/20  0/20  20/40 fail     20/20 20/20   0/40 fail
  RAA228246  0/20 20/20  20/40 fail     20/20 20/20   0/40 fail
  RAA228244  0/20 20/20  20/40 fail     20/20 20/20   0/40 fail

A second RAA228244 and an Infineon XDPE1A2G5B passed every round before
and after.

Fixes: e6fe3ea04f01 ("i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO")
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: stable@vger.kernel.org # v6.3+
---
A follow-up to my xiic block-read series, now in 7.3-rc as
b7e6df2f52ed, e6fe3ea04f01 and 840d8acc8792. The second of those
stopped NACKing the final byte of a block read that fits in the Rx
FIFO, which leaves some PMBus targets wedged for the next couple of
transfers.

Tested on a 6.12 kernel carrying that series, against an AXI IIC
controller with an FS1412, RAA228244/RAA228246 and XDPE1A2G5B behind
it, using plain and PEC block reads and the byte reads that follow.

The same happens on a second board, where two of four ISL68225s behind
the same AXI IIC core fail plain block reads and the transfer
after them. A capture of SCL/SDA taken inside the FPGA shows the
mechanism: after the last byte of an MFR_ID block read the master
drives ACK, the target starts on the next byte with SDA low, and the
STOP the master then attempts never appears, leaving SDA held low. With
this change the last byte is NACKed and the STOP is clean, and all four
pass.

PEC block reads do not regress: 1000 PEC block reads of MFR_ID per
device, each followed by a byte read, on the FS1412, both RAA parts, the
XDPE1A2G5B and a further RAA228244 passed without a failure, both with
this revert alone and with Siddarth's patch on top of it.

With this change a block read ends with a NACK, and so with TX_ERROR,
like any other read. That puts it in the window Siddarth's patch closes,
where xiic_process() sees TX_ERROR before RX_FULL and resets the core
even though the data is already in the Rx FIFO:

  https://lore.kernel.org/linux-i2c/20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai/

The two touch different functions and apply cleanly to v7.3-rc6 in
either order.
---
Changes in v2:
- Revert e6fe3ea04f01 outright instead of moving the threshold back by
  truncated), and with b7e6df2f52ed and 840d8acc8792 in place PEC block
  reads pass at the original threshold. The code change is the same
  single line as v1 minus its tail == 1 branch, which could never run
  (Siddarth, Sashiko): reads with fewer than two trailing bytes are
  padded to SMBUS_BLOCK_READ_MIN_LEN first.
  Sashiko review: https://sashiko.dev/#/patchset/20261008-i2c-xiic-block-read-nack-v1-1-94882af6e598%40nexthop.ai
- Link to v1: https://patch.msgid.link/20261008-i2c-xiic-block-read-nack-v1-1-94882af6e598@nexthop.ai

To: Michal Simek <michal.simek@amd.com>
To: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
hand: that commit's premise was wrong (a NACKed last byte is not
---
 drivers/i2c/busses/i2c-xiic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 5e397a7e63f6..76ef9c26ed57 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -569,11 +569,11 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
 		} else {
 			/*
-			 * All trailing bytes fit in the Rx FIFO. Defer RX_FULL
-			 * until every one of them is buffered, so the drain
-			 * takes xiic_read_rx()'s bytes_rem == 0 path.
+			 * All trailing bytes fit in the Rx FIFO. The widened
+			 * condition above guarantees rxmsg_len + pec_len >= 2,
+			 * so this cannot underflow.
 			 */
-			rfd_set = rxmsg_len + pec_len - 1;
+			rfd_set = rxmsg_len + pec_len - 2;
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261007-i2c-xiic-block-read-nack-d2b735baddd3

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

