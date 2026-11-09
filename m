Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231566;
	b=QOzOo3RZPvf6U+ABSMIPyn5uzk73tb5hno6jaNeYnxU9o4gSxM+zdX9zZnouuR3SloKn
	 8zaFSHGJU7aTPK6FLI5JHTJzzvyN1uKPwIwznj7qRA0VjbqyzkRr5jhf2T5JERcSF9599
	 P18ZnDFL1aYBREoVmZ0gPZEPzYZA4YqkDn2YwmgONIJAYSFu3NUKQJ48KK76aPQejORO3
	 Rd3BoAo76OBXyIOHMQ3jwxaqqRsjxc9xbCbvrxtb7RA4ivWARXkFVMyAS31tAvmyvQe00
	 mBmwAG6vmb0i7Ed8iwIJ9u2mJKYhES0avr2vA18BgzOuVIXc40Ko1jD/irTH/SgAXCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231566;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zsUWn8Et0nBc+odXOkeAQsT02vA8TSVYTUg2RO/wL+Q=;
	b=GB4ZvA89s6jQdy5DZixjEzgI6DoUUicSu5RO0ji8wlMC6W5pAZLWnvrVeWX75cPNXMZM
	 Vk0peDGxudNdNSj1T3Nbqc3+KQGF36XYapyDGaSRDjncRKqdVa6f7e4QUOcVYn1RmlngT
	 ZkT3LD9gmfRV1FDubJ+9yfhPgWFKtllCOSevpkJcaJ62UYN/AYPvUtNrYfaXvz33zkqF8
	 NZH0nzSFVGdS82ckGETJpWcDXbCFt2gpS7m3LHfoiuXaEPMK//A/kOwL4juk/8CHZu1wq
	 rOAc8CLGR+6ksnvpBwnXxok8GI9GuLuQ3Bf1gDf9huq2EilwZBgXVYnRtWflI/4wbfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpI4+nUr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE057606D816;
	Mon,  9 Nov 2026 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpI4+nUr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627241F008A2;
	Mon,  9 Nov 2026 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231565;
	bh=zsUWn8Et0nBc+odXOkeAQsT02vA8TSVYTUg2RO/wL+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PpI4+nUrFHCAuITDOYceHzRMS9Ltj7neXfQdIhbmKA+Or5oZ89W5fud3v9byYAWnS
	 KGL6VMZ5FfIahEJoJp70+QRnzPRlhTNjrfRWf/YT1jM0q2bt0etqOq93flBXKfkSB1
	 RD7yjSttwCr/K8SvFn2n7uleYd/bmo54+LF5mzKTLRbbLzhSqXNRWGecjPYJT6aIAy
	 JMfa41kU2Pdqk1FbbnL8pkQm7QoH2xhhXa1z+Ch3iMM53NvMbHgxTtff/MQGMgx2ii
	 Ilx5nkfgCsh+ub9S9t6G75oZbIIaRdK+WgiKi+GdVsWlkCJzyNUaAO4FP8qaStQUac
	 VGGzg6B+yRi3g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Ping Cheng <ping.cheng@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.10 4/5] HID: wacom: Write shared touch initial status only once
Date: Mon,  9 Nov 2026 13:39:05 +0000
Message-ID: <20261109133911.3026622-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109133911.3026622-1-lee@kernel.org>
References: <20261109133911.3026622-1-lee@kernel.org>
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

From: Ping Cheng <ping.cheng@wacom.com>

[ Upstream commit cae3031c691dff0be61a26bc64e31a6939010d5c ]

For consistency with how the shared has_mute_touch_switch is handled
during registration, let's apply WRITE_ONCE to is_touch_on too.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[Lee: Resolve context conflict around is_soft_touch_switch in
      wacom_set_shared_values()]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 465d075d16f9..ad570af50745 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2353,7 +2353,7 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 
 	if (wacom_wac->has_mute_touch_switch) {
 		WRITE_ONCE(wacom_wac->shared->has_mute_touch_switch, true);
-		wacom_wac->shared->is_touch_on = true;
+		WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-- 
2.56.0.506.g506a7eabc5-goog

