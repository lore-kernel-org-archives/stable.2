Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B023DCD96
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972579; cv=none; b=BFJ87H34tOZkIFyMPaLB8LUBMv+TaqZU6jpoEhslaN1hCH7YPhJYQedPPxzVuavAvjkuY5cQDG4AQ13lZiLJZmx0/0/DwnP2KQHORwZ6ISbsMQ0dj4fHcH25l7EbQ58LfO68xwK7ciWDsne/29ok2kUTSWXINwJgowmLacy5CgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972579; c=relaxed/simple;
	bh=1zuKCeX4ubKsHdgFEEDZASCv9P97PZ9/9qgb9og1SDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha00Egl0zXDA9Am6eRik04CdZcuCTzeM/8qZYdI6oAmKbVkIaDTeTf71JkuAZxOo/R468oHTsTnrXIexxNHoogK/oX1b0B4IxHc6UXcviNs6n0Jl1F3kn/K5OD9EF2q1yTusdAnbTGZMLbjtvi7gF95OIB7Z1wTsb5FqIrHqVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbCm341R; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbCm341R"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c57d36d37so811252485a.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790972575; x=1791577375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxbnn0+HyLrQHSw5N5vcj8DOerEWS9jU0mk7xDwdzyg=;
        b=AbCm341RvLDwkmK/S7LLO03iuarUsWKqjvRSx674cm3+gptpv+rQeQ2f30UfVWWZF5
         YmJ1dun5ajVItEBWyw3VOsnJvCOz7p/s5zJy6v0xH3lvzWAYFmCmarBD4JU4ryjYLGrK
         z9nEsVgN0yvPS3S/lDfXNQxkfKQtxN/nNmIUnLCmxAzWp883aNhSBujpc+5u9dW7N8x9
         Xfjiq3wr8f8uQmsCc1qHmmIZ7L4xxo+MuZW343D4Up5IoW+u1rtzxSzThxWKkqTgqScq
         Xf3hvlpMUjItdqKnSrhAquYe9YMm6/rwdh3zWBTvUqGM1x+AeBOPEDZyGaRTjV2CP7N2
         0pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972575; x=1791577375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gxbnn0+HyLrQHSw5N5vcj8DOerEWS9jU0mk7xDwdzyg=;
        b=YpRZw/DUGQVpqnBSKi6g8UArlyeFawCuy4cABtsK+6hoYTbUgbr6iTbZiUJnVQZPj1
         ifNJlGh/cR4VVnN7JLGuW0DNelbZYUgafmGiwtUS0pdVmTJ9Jk34UGTtVYRtbfrHPk0/
         6CjYuaJ9rZquZYlWpbAz2Qbvk0Ta+NMgJ99Lb+sX7GK39lLVBEL7cgwf1+mIZQFUi7ir
         dN/9zQn86hU5+flYiWl2WKtfjMfTvhgT8c6UTceuYIYxjfx4Xp+HENdMN0bVL5AI9Qxk
         fyAz4m8we8sibD9MJO33JSM4Vy1+rjrIU4egAMlzi3EkG+v4SV4iuaCYY5jKxOEQWgyW
         49Zg==
X-Forwarded-Encrypted: i=1; AKwUvBzKG4xTQG+5SFYrF9VAVkIVW69pcSMZy57i5hup6NcTOS86T8AhBI34gS9fjICdnXa00u6GBFo=@vger.kernel.org
X-Gm-Message-State: AFuF++lwO8GvreGdqJEiFWc8F6kMJdM+uzojgQ0LpYluJXEbj1koF+0P
	EgdFLPXqPcQ/LoQqdbL/5YRW128hD89OeIPSWoTzLeb5k1X74TNBtbw9
X-Gm-Gg: AYBFou0Vn/BHeBzn+b0jm02/FZ80KJmi2Hl8PH4fP5UWlYCYX5HQoh8Jo5yeidJSBhj
	NDzBUWkcTmpHqz1BV5oO7r2YBYEd1yWGtYn3j2TcHQKlE1VFFGW2LsRNsRA9hLFM6hn0s4LpNWR
	nyTJoKuU8oZ5mPQTslJsJUUiVg+f2F5SkNmuQFRrdc45Er/8sYpq7SEd2vzlk5zvRLwrlhoCBzW
	An0gqvT75CllBhFjyEO3dwKzBCG+7r1YixIKvrTiWZBkAOiAhAePSyud4qO7SmSoU4YjkE836hi
	DpYM5Oh7hyyynlNh04E8JVX9BtnhJO/ZN1Js5pjXX9TN86w6DUtdmPBuILWgayie8GxYoee1tu2
	lo0cQhJtN6JIw5NKUehTafMzO2y/5JPtRgEK4wVmtgKrGnS+lplt5ZcuZZmClIUiXiz/JMYBah5
	e6Tbqy8W5C7AjD/v15dwKketKdjIpsDwutv3WC2DjPtzFKBXalrA+3u6qCHTVlrnk5nr+fwhQrr
	l0RaM5XBkJw6tZmyGfjHNiClYnx5VckRL30
X-Received: by 2002:a05:620a:1b95:b0:93c:5dee:f04a with SMTP id af79cd13be357-93ce7a9de6bmr754544085a.7.1790972575184;
        Fri, 02 Oct 2026 13:22:55 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.192.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2d361bsm308676985a.45.2026.10.02.13.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:22:54 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Saranya Gopal <saranya.gopal@intel.com>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Seungjin Bae <eeodqql09@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: reject GET_PDOS responses longer than requested
Date: Fri,  2 Oct 2026 16:21:02 -0400
Message-ID: <20261002202102.599998-1-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092932-arbitrate-snorkel-3fca@gregkh>
References: <2026092932-arbitrate-snorkel-3fca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

In ucsi_get_pdos(), the number of PDOs is derived from the data length
reported in the CCI register, which is provided by the PPM firmware.

The function requests at most UCSI_MAX_PDOS PDOs on the first read and
PDO_MAX_OBJECTS - UCSI_MAX_PDOS on the second, and ucsi_send_command()
only copies that many bytes into the buffer. However, the returned
length is taken from the 8 bit CCI data length field and is not bounded
by the size of the request.

If a malicious PPM reports a larger length, e.g. 0xFF, each
read is counted as 63 PDOs and ucsi_get_pdos() returns up to 126, beyond
PDO_MAX_OBJECTS and the number of PDOs actually read.

ucsi_get_src_pdos() stores this value in con->num_pdos, and
ucsi_psy_get_voltage_max() and ucsi_psy_get_current_max() use it to
index con->src_pdos[con->num_pdos - 1], resulting in an out-of-bounds
read. This happens without any userspace action, since
ucsi_get_src_pdos() calls ucsi_port_psy_changed() and the resulting
uevent reads every property.

Reject such responses in ucsi_read_pdos(), if the PPM reports more data
than was requested, print an error and return -EPROTO, so that the
invalid count is never used.

Fixes: b04e1747fbcc ("usb: typec: ucsi: Register USB Power Delivery Capabilities")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Print an error and fail instead of limiting the count, as suggested
 by Heikki.

 drivers/usb/typec/ucsi/ucsi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index bef3f9b71d71..17beec16fe19 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -862,6 +862,7 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
 			  u32 *pdos, int offset, int num_pdos)
 {
 	struct ucsi *ucsi = con->ucsi;
+	int len = num_pdos * sizeof(u32);
 	u64 command;
 	int ret;
 
@@ -875,11 +876,17 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
 	command |= UCSI_GET_PDOS_PDO_OFFSET(offset);
 	command |= UCSI_GET_PDOS_NUM_PDOS(num_pdos - 1);
 	command |= is_source(role) ? UCSI_GET_PDOS_SRC_PDOS : 0;
-	ret = ucsi_send_command(ucsi, command, pdos + offset,
-				num_pdos * sizeof(u32));
+	ret = ucsi_send_command(ucsi, command, pdos + offset, len);
 	if (ret < 0 && ret != -ETIMEDOUT)
 		dev_err(ucsi->dev, "UCSI_GET_PDOS failed (%d)\n", ret);
 
+	if (ret > len) {
+		dev_err(ucsi->dev,
+			"PPM returned %d bytes of PDOs, but only %d were requested\n",
+			ret, len);
+		return -EPROTO;
+	}
+
 	return ret;
 }
 
-- 
2.43.0

