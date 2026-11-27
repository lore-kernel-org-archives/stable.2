Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810265;
	b=ubw1Ys9yixwcXps3o0l7NW4ULAx0cZZ8pBoKOavxcN4IDxrzEpCVYmcg+loROQdJOOK2
	 LNIn0oNbb6bloiBucy3V4oe+uZQ/CeRySr9R6+9XtDirfodD2by9Lb9L8+9rK34Juf10W
	 bG+4Y9fLrajBeoS+KgV2VrolgjA3CYnLG7f4OInOYNaHawy42RKhCW6VPAn3s2E2uIVga
	 UssRSfTNkbhdkga/FlUUDn7IY8xcR/KhTWo70o6rUTHlmvrz4fDymWs6LNLjM+vdksgpw
	 XBzoXIVEnSO4DElljOLBeYg4HsNa2C81PbE94OkNd77roEiUWsza1UyrQWQ4kopV7lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810265;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gqPnNO5G14g4oYtIRt00IeE1Ui7W4LxZXQWzHeIbCRA=;
	b=ivXkXGNmNzs5EKxapP7wGj4uJvup2J11aNL+U0oyGbxLelYUqlKUppU2J99aZX8b4lJ+
	 2YXZr66vd+pto/cPiNMy2NE9CwiI1eJLuQFtrZeXU+Lb0FHNWXbxAccLJeVFnk6cWK5dt
	 Gbc7k26PoUp/Y9U+gP9Q1/dNYWbg5KKhU0JYds6LLFw8VLdtyYnQZEbgJR9v8gDrMR+MR
	 u9JK6cm0/ADpjwn9CTdO1ZxkNBjXdGdYhL615Q0xfxRptVedaoF/3DYwbYht4Hq1cQn0i
	 jys3TJZS8QqI01o8iQJ0L9QKsvf+dI5NL0M3I0aPkzM+Yuuh2cOlm0zhnNkfNAVV1fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0WrqxS1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553E606A326;
	Fri, 27 Nov 2026 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0WrqxS1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E4C1F00923;
	Fri, 27 Nov 2026 20:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810265;
	bh=gqPnNO5G14g4oYtIRt00IeE1Ui7W4LxZXQWzHeIbCRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o0WrqxS1MlLYWePyyY8CtqzrrLm1I5GrQuXhU3wr7EeC7Up8Eps4xj629cdlwFLta
	 3m5SXMHGIheaEwHwu9W5D8WlF3ieMqfLEyO8VMAQUUlA+PtEOFgP1Wq4ZqOozUPUgU
	 Ay6NkFT2tynHyYaiiTo3kRkkj/bC84UcUA90aRbhZqcp13KgSejYLsUtnSGpe3wOVx
	 cIH0PjMJXnKPO2ii5A3MbgWkhbnCflHIA14K58csbMi8C58vbthUb231fN06CrJ4Zv
	 viqlpaimrccuFrpGUdNFdQDmh2mvNa/naLTZ4AKyud7x/KqZynv9d5jeDvsfz1QnlS
	 TJTA6R2YkkKdw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vojtech Pavlik <vojtech@ucw.cz>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] Input: adi - prevent off-by-one write in adi_read_packet()
Date: Fri, 27 Nov 2026 20:09:55 +0000
Message-ID: <20261127201050.3532488-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127201050.3532488-1-lee@kernel.org>
References: <20261127201050.3532488-1-lee@kernel.org>
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

adi[i].data holds ADI_MAX_LENGTH bytes and adi[i].ret is initialised to
-1 and pre-incremented before indexing adi[i].data[++adi[i].ret].
Checking adi[i].ret < ADI_MAX_LENGTH therefore allows a write to
adi[i].data[ADI_MAX_LENGTH] when adi[i].ret is ADI_MAX_LENGTH - 1,
corrupting the adjacent field in struct adi_port.

Compare adi[i].ret against ADI_MAX_LENGTH - 1 so the pre-incremented
index always stays within bounds.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Closes: https://sashiko.dev/#/bug/linux-951334ec-a996-4dc4-a03b-d7e6f716e5de
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/joystick/adi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
index e07b71978509..cfd585f89c2c 100644
--- a/drivers/input/joystick/adi.c
+++ b/drivers/input/joystick/adi.c
@@ -141,10 +141,14 @@ static void adi_read_packet(struct adi_port *port)
 		for (i = 0; i < 2; i++, w >>= 2, x >>= 2) {
 			t[i]--;
 			if ((w & 0x30) && s[i]) {
-				if ((w & 0x30) < 0x30 && adi[i].ret < ADI_MAX_LENGTH && t[i] > 0) {
+				if ((w & 0x30) < 0x30 &&
+				    adi[i].ret < ADI_MAX_LENGTH - 1 &&
+				    t[i] > 0) {
 					adi[i].data[++adi[i].ret] = w;
 					t[i] = gameport_time(gameport, ADI_MAX_STROBE);
-				} else t[i] = 0;
+				} else {
+					t[i] = 0;
+				}
 			} else if (!(x & 0x30)) s[i] = 1;
 		}
 	} while (t[0] > 0 || t[1] > 0);
-- 
2.56.1.839.g22a8290db9-goog

