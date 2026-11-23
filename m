Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795437243;
	b=rAyv4eR/fQ/tift7pKYK0qTA6lNi/lyR2QDc2wo6WTNc6NCD17nQciVyUKqzNgDskR+K
	 v8FKdXt4wuvNQpBFsebCJX+2NCBs2iVIKk0DeA4kk+N2xbtOjZPjNoqv4F/sWkUrnVqLk
	 vraUBflIwS2lEPF53NAiQPwzk2mO/rQRrtIfBcn4hogiLywEKral/L76dZcyfOkTmGuBm
	 aEAWGwy4g4AcWD5BwxQ7etVEig12mlpFB1S4AoQtyxUBtZhrzDLWhx2/uUK6W04o5Rb+N
	 v2AIDZepifCTl49iadE9nz5kEcdsrQPUe///IGGBoCPTjsSh6qTSp6jBef51nv14AVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437243;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xX7UOyGR0tdMya+z6aiapgRXDH0k+54xytWGOOhjx6k=;
	b=HMijZPpi96O0wm0avm4AF0XymkdZ4TD7YX7BMdAhfW4zWF3E4Bg/rSOy6Cnpa93hSIQZ
	 0LyHjqahTGoF3NLsIzJS2i7WvL0nCrhixcl9GastiJdQOk//rXshtEWa8OxKolUG1urOA
	 dQMBylSKispXgxYPQ4WQ1rGf/lYYnRr3a7vCYfFM8Ozdm72U5LQd7ZzkrUzgmC9ctqakY
	 d8YNEyZNkey/k1hJdaTxSjLT7WZez8dURyFGQBgNPf3hI6qIpu96RbzXpigjmYu9D6Y0v
	 iky7xHhc/OcEWxDAqGqSIumKjJ/RTp+HgejESER78PQclyTFY+bwBvlIVshCLo3kiEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhXlc2yo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF5606A31A;
	Mon, 23 Nov 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhXlc2yo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795437242;
	b=XlnLNNDD02eUVZx6iN90g3+bRUJP7MIypraJnXvg4VHyKKc05nshsqKh3MIpQareZTw7
	 Cbnkrg9gYR43+1XhbM0lf6Vo9n/bOvSj2JdAdlCF9auYLoGo42VdGFCK1+uzAEmWWOpAr
	 Q3ouLl4jUaAXZUfcH5hqRbs4Pflf7TEcB4xX20ELk7uYQmzCnD+mESmDijcE8OTTqNJJt
	 lVa/c/JxeHbeKzVIose5a7c1GFWfhuJ1k40H2iEo5V210F9q0q8JULPwb/mvM4riT/0yI
	 yD7muXqEgZF4cCQlerYc7NE9/xZaOKseFohS46e57wnUwlO3BwU1YXWcNIx/LaMGMkg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795437242;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xX7UOyGR0tdMya+z6aiapgRXDH0k+54xytWGOOhjx6k=;
	b=r8esFm27QaTf53MxfWxOUkxWztx8A/MC4z75UErkHbMgPdG9BVbKp/imVP7Pabi3nrCx
	 UPQrV9PE4I2buoPVtiuDLyFq4oaYdCZXAwsws1dD8SIrrRYbLemqoSLs1iWgo2FfRSKKQ
	 j1VIiinvGHzu+Xb5Kaq2TJA1QBFtyXaWnhaAJTose3X12YC5om0pI7WYnxZLuPJWRKjks
	 otwHmMOsvBlkhY+JJ1QGVnmxPafcdmNRHBIceq2nVQLYe2JSQUnGtLcBs43JOCBX+6rjk
	 Htj05Yyoiq27ZYOpxrL8ev1i6yHEjThdepRnbjGI9IEDdaeTbAXw23dARGe3p6q61Xw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6CD961F000D0;
	Mon, 23 Nov 2026 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795437242;
	bh=xX7UOyGR0tdMya+z6aiapgRXDH0k+54xytWGOOhjx6k=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=fhXlc2yonS4hmEVTqTLkAt5PsAZHMJbEqvTULajXQf8rbEiLwBtmHqNnBJF42+lwL
	 ZQ59ayDzuZ1K92z3tNUcgACKpdJv6QnfZ/spe42mV/ju4RUjzxcrA1z6BJBHE5wRRF
	 Jh2NnHtrAZaNszti/VEQTQ52oueubDMhps+E+Zzqrbc+ekXBb7XJANy7M2eiT18cpq
	 SZ/rWFbJ1YO2A4D2b64RcTp9lTNI7UK4emIu8/4gWoubT0QZFctq+lx4rW3kVkjZni
	 gDAHGwpoXarvx4+oOHhpWbpZWTuGSKNex4r7GDnKtYxi+ToongfdoTswWQeX0m72nk
	 uKrwduwaqlIqQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C36FB4C46E;
	Mon, 23 Nov 2026 12:33:51 +0000 (UTC)
From: Markus Haberlander via B4 Relay <devnull+markus.haberlander.rosenberger.com@kernel.org>
Date: Mon, 23 Nov 2026 13:33:49 +0100
Subject: [PATCH] i2c: cgbc: Fetch the status of a write transfer
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
Message-Id: <20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com>
X-B4-Tracking: v=1; b=H4sIAKwyBGsC/y2OS24DIRBErzJiHSRoeoDxVSIv6KbHJpI/ASaxZ
 PnuxnGWT6p6VXfVpBZpajfdVZWf0srlPMB+TIqP6XwQXfJgBQa8teA0H4h1Ada/tXTRrae+NQ1
 mxTlImGNY1Oheq6zl9uf93L+5bfQl3F+y/0SV720M9ndMXVPn45jbTSgQsosy24wLmBwQQ0wkw
 WdMYhIgmuycvDyUmmi+nE6lj9tMAXwk711ktHZlB6sLThY/C0VKiywEhGr/eDwBSvegF/sAAAA
 =
X-Change-ID: 20261123-cgbc-i2c-write-status-20f457e75879
To: Thomas Richard <thomas.richard@bootlin.com>, 
 Andi Shyti <andi.shyti@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Markus Haberlander <markus.haberlander@rosenberger.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795437231; l=3950;
 i=markus.haberlander@rosenberger.com; s=20261123;
 h=from:subject:message-id;
 bh=XQwD6EKXMi+lwJWT9kCfMA1cmv/s0ZvtS6yQ8uN2KzM=;
 b=NZLJpn+y3fV4UzqY8xCgHdLb8y/ndlimNJyE9xDBp025pxxjv43FgrolBchQx1geGMSqthwKc
 G0pIgwfE/iRBVmyglI0BJ/p9hgMdp+wTZtJa2a5z1RFoVwwigO86i7D
X-Developer-Key: i=markus.haberlander@rosenberger.com; a=ed25519;
 pk=baNIWlZCf58g17gE2FS6ir0ymNwyBXguoQENSJkXdeQ=
X-Endpoint-Received: by B4 Relay for
 markus.haberlander@rosenberger.com/20261123 with auth_id=1612
X-Original-From: Markus Haberlander <markus.haberlander@rosenberger.com>
Reply-To: markus.haberlander@rosenberger.com
Content-Transfer-Encoding: 7bit

From: Markus Haberlander <markus.haberlander@rosenberger.com>

A write transfer sends the I2C command to the board controller and
returns without reading the controller's I2C status, while a read polls
the status until the controller is no longer busy. The status of a write
is therefore never fetched:

- the write reports success before the bus transfer has finished, and
  an error such as a NAK is only reported by the next transfer;
- the controller keeps the status of the last write pending. On a
  conga-PA7 (BIOS PA70R026, board controller CGBCP032), a board reset
  with a write status pending does not power the board up again: after
  a reboot that follows a write on the general purpose bus, the board
  stays off until it is power cycled.

Read the status after a write as well, as the read path does: poll until
the controller is no longer busy, return the error it reports, and treat
any state other than idle as an error.

Tested on a conga-PA7 with v6.18.64 and "i2c: cgbc: Propagate hardware
errors when polling read status": without this patch, a write to an
absent address returns success, the next read fails, and a reboot after
a write does not come back. With it, the write itself fails, the next
transfer succeeds, and 14 reboots, each right after an acknowledged or a
NAKed write, all came back.

The patch and this changelog were drafted with the help of Claude
Opus 5.5 and reviewed and tested by me.

Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Haberlander <markus.haberlander@rosenberger.com>
---
Hi Thomas, hi all,

this is my first patch for this driver, so please bear with me if
something is not done the usual way.

We use the conga-PA7 in a product, with the mainline cgbc drivers. While
bringing it up, we found that the board does not power up again after a
reboot that follows an I2C write on the general purpose bus. The patch
below describes the cause and fixes it.

While preparing it, I saw your series "Congatec Board Controller: Add
storage devices support" v6:
https://lore.kernel.org/r/20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com
Its patch 2/10 ("i2c: cgbc: Propagate hardware errors when polling read
status") fixes the read side of the same function, and this patch is the
write side of it. As Lee wants to take the series as a whole, I based it
on top of 2/10 rather than send something that conflicts with it.

Whatever suits you best is fine with me: carrying it in a v7 right after
2/10, or me resending it once your series is applied. Right after 2/10,
it backports to stable together with 2/10, as both carry Cc: stable.
After 5/10, it would no longer build on stable kernels without
"i2c->read_maxtime_us", so I would send the backport myself.

Thanks for having a look!
---
 drivers/i2c/busses/i2c-cgbc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index dfdb9ffc6..2361591a1 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -254,6 +254,22 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 		ret = cgbc_command(cgbc, &cmd, cmd_len, NULL, 0, NULL);
 		if (ret)
 			goto err;
+
+		ret = read_poll_timeout(cgbc_i2c_get_status, status,
+					status != CGBC_I2C_STAT_BUSY, 0,
+					2 * algo_data->read_maxtime_us, false, adap);
+		if (ret)
+			goto err;
+
+		if (status < 0) {
+			ret = status;
+			goto err;
+		}
+
+		if (status != CGBC_I2C_STAT_IDL) {
+			ret = -EIO;
+			goto err;
+		}
 	} else if (i2c->state == CGBC_I2C_STATE_READ) {
 		xfer.write = 0;
 		xfer.read = len;

---
base-commit: 1cb7268b6638c411fc32f373e965eb8ba9e9b2b4
change-id: 20261123-cgbc-i2c-write-status-20f457e75879
prerequisite-patch-id: 4e27d38e51d4920d74478abe76d4ae0a2440d33e

Best regards,
--  
Markus Haberlander <markus.haberlander@rosenberger.com>


