Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597601;
	b=D/Y0OHSCcx0QbKXo5R8gz9x/ffXvIYoIBXxmqQxhZr9bn55KjyTgWIGzwd2ikYhPSxsj
	 Z/GImFLTK2V/QaVw9aiU+zdT2J0BCAari0VKWH4VVBwB9npF0So9pm3SnGSkrDPyNZGI3
	 VJeSGfdS1B9205n5Al72adE7Z6SXJTE9ExpL3X3t7aas5SBEj1CzLEYt+ieFwAYNIoG3P
	 VrogdZ0aMSum4g2L8T/IAQaeymW057rr89YioiRsIC+FyjTqK0XDF/7nGKY07XsQ7vc6/
	 65Mvq9EnHZq+1cFaJeCecfuvhAA9/FOT3MKbleoWNT7YJp1omZLXrXxFJP3XMGH8yXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KrrZR7Yas+60sGGjOVcPMTCAlDBX4qIpvNx54Ov+Vv8=;
	b=LmLwI8I/Qzff/wreNaEbkL4T1SD1kSFsASb/90K/SmNdujjGRDrFk4mVsm26Rc9AgdVp
	 T9D7l1DEAFHA2+KhSXFs8mlvDlZAOBual9oyCo25eG/4fqJ49TcEv0DE20/VkJS/80woE
	 +HECDCb4aXIF7ST2sXjzZdQJ18XM+b4LeR2l6pOIr+FYD/9/YOSkfs4bR5YygEmtbYlm2
	 307wd18lYp1G3ieQD+ok6sqLH5p8iIz5pPG8y8NLQHYY5AZ1ak5uIr3KOSwnSQH2yRlhf
	 jU1MvcwK6Jguro5aEQ2a23ixa0UYP/yX0XLfr+mMsa3z/G7J4CbYCABZtqTFuBEB/8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0tnP6cY;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF7606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38BF7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0tnP6cY
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3866a784546so7359598eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597600; x=1796202400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KrrZR7Yas+60sGGjOVcPMTCAlDBX4qIpvNx54Ov+Vv8=;
        b=Q0tnP6cYbZz3pfpyHrAMp7BKcf/DiF8GFu/4jtniXlCszClpJsdGVWuiydsiDhraH/
         w4AoBpfWh5O//j2k25pAZ3G8S7ON5fAzyVfMtyRHo+d7JgN/Q7v3OrzWG6rssfJSnbm9
         HtdGbDqY8ofqhduUFK7VOdJF69Sh13rn7LYZfsw/9C3R2J2A1T27qwmhWftDQl0gGZaV
         bQWNewrjAswXAV32lteV/1FjJU7BkEuWQgRogx6BkluL+V/c6bz/TIHb8re/FTFjy1K0
         muzEpFKul2ZLWH3CYXV9gEl/oZPezDicIZzcZ+WLJw8oCtlOf+BN5FfQI/vTbTGCJdLq
         AtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597600; x=1796202400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KrrZR7Yas+60sGGjOVcPMTCAlDBX4qIpvNx54Ov+Vv8=;
        b=Ga6/NSrjtHUf7ShIiB9T5Skt9WZI94InlZGQsuy1eEohPZHKr6+DU7el+l8yJF2JMI
         ec3/uXACuGbkrsrKE6L6+mm5fR7PhzG9KGB3C4tWeIHtp38qT7AJsEyPBRADhCUyekeD
         BQajF9CzU0Aq9KE5eKXOFeL9YyOGBd2T2GN0iQ0rPKy6DF2ihyS9J3nUbT0nqfC7w38N
         px2xuNRL32RbGRj9vdXM0VpA1pGUkovbiNAyq6MmzHq08qXHdeyTYPlJEjH0QEY4Q/zs
         neHNZnCv8XJJR4hKi4JIPX+39GI5IiAq7DJAVF2YUNs2wu0MnsGAqi6A4YcvNYoPU22+
         E+Xw==
X-Forwarded-Encrypted: i=1; AL+hErEM6cjbqu7zK7ILwPvEl4aXIuCBhIRBXDDAHo+Rea63nDZMU82iCklsPKqmP+wgFf1KICT93ys=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OhclunaHzLWTBKXY8eRJozHjsyyFOVqfHLzCAAsDEPZBgF+uk
	jwyxBPhBKR2hPENcwce7G+KZPn0MrZYUDHdPzCm1aQMyMwH73OudRo8k
X-Gm-Gg: AZFdTZcT8X/l2AoQ5MWRahe/3Y8KV4KOGsVOIecq5kyvQvW9xO2v6EJhN3ZUkGCUFx8
	AFQ3mbwag2h582381TzwoQ/OKN2FxpE5GYiiP4ihFitKluOHNqvpxDHsEuLwyo1OlyPdhSv8TkC
	htXluBwmcpTRuiAUqGlAttVaNqVZPGbRvoAB4sRUUr8tUG63rcIyYCH5G3IN4bBqyTgrLiXQmPE
	b+ry0to2T+2ImLSQq7zjxkRmQeb+2XAOXNjTH6j/gTfsluBz0pPI9v/15BMKBWQQbFcm+hcAO4x
	rGF+k65NNde/UZs3joT8OB0RdXs75V8NSDOt5jPhxOqNWq8taBQFOIbXV43dFtg8GaQszmfdVXx
	mrht/1KI6tgZLMiMPlalrRigqOTnP8v3DVut6nGG9VdU57cPwSvbHz+RsbKEXGTpOrK0ithH15r
	MTzzibb62LmIE+vv9GFSuZHk3I6uMh+TH2G9ZTLs/XPXj3xZZTuRfRGVn3vGpur2soI8bKBG592
	YAn9ll2hkNMrKxgAMqJTUF0ddsSsJr98ToUc2RvuZ0Hv0c0/muGU1i08/TvolXeOeEBWMx5hFNx
	NIj6CAR2iZPiAXTqpY0dlQJa/bUYk+76M1bTuAIXin8eKdt6Uy562w==
X-Received: by 2002:a05:7300:ce0f:b0:386:b827:de97 with SMTP id 5a478bee46e88-386b827e2ffmr7302480eec.34.1795597600287;
        Wed, 25 Nov 2026 01:06:40 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm58712596eec.24.2026.11.25.01.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:06:39 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] HID: intel-ish-hid: Reallocate the descriptor buffers for a longer response
Date: Wed, 25 Nov 2026 17:06:32 +0800
Message-Id: <20261125090633.1385386-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125090633.1385386-1-maoyixie.tju@gmail.com>
References: <20261125090633.1385386-1-maoyixie.tju@gmail.com>
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

process_recv() allocates hid_descr[i] and report_descr[i] only when they
are NULL. It then copies each response into them with the length of
that response. After an ISH reset, a longer descriptor for the same
index can overflow the buffer allocated for the first response. A
second, longer response to one request does the same.

Size the buffer to the received length with devm_krealloc() before the
copy. Ignore a response whose done flag is already set.
ishtp_hid_parse() may be reading the report descriptor at that point.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer. Not tested on
hardware.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2:
- Ignore a response whose done flag is already set (Sashiko review).
- Shorten the commit message.
v1: https://lore.kernel.org/linux-input/20261123092816.2200718-2-maoyixie.tju@gmail.com/

I used an LLM to help write the harness and this patch.

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 25 ++++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index ec5e8afe77bd..d1eccdc37e7a 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -68,6 +68,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 {
 	struct hostif_msg *recv_msg;
 	unsigned char *payload;
+	unsigned char *descr;
 	struct device_info *dev_info;
 	int i, j;
 	size_t	payload_len, total_len, cur_pos, raw_len, msg_len;
@@ -172,11 +173,13 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
-			if (!client_data->hid_descr[curr_hid_dev])
-				client_data->hid_descr[curr_hid_dev] =
-				devm_kmalloc(cl_data_to_dev(client_data),
-					     payload_len, GFP_KERNEL);
-			if (client_data->hid_descr[curr_hid_dev]) {
+			if (client_data->hid_descr_done)
+				break;
+			descr = devm_krealloc(cl_data_to_dev(client_data),
+					      client_data->hid_descr[curr_hid_dev],
+					      payload_len, GFP_KERNEL);
+			if (descr) {
+				client_data->hid_descr[curr_hid_dev] = descr;
 				memcpy(client_data->hid_descr[curr_hid_dev],
 				       payload, payload_len);
 				client_data->hid_descr_size[curr_hid_dev] =
@@ -197,11 +200,13 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
-			if (!client_data->report_descr[curr_hid_dev])
-				client_data->report_descr[curr_hid_dev] =
-				devm_kmalloc(cl_data_to_dev(client_data),
-					     payload_len, GFP_KERNEL);
-			if (client_data->report_descr[curr_hid_dev])  {
+			if (client_data->report_descr_done)
+				break;
+			descr = devm_krealloc(cl_data_to_dev(client_data),
+					      client_data->report_descr[curr_hid_dev],
+					      payload_len, GFP_KERNEL);
+			if (descr) {
+				client_data->report_descr[curr_hid_dev] = descr;
 				memcpy(client_data->report_descr[curr_hid_dev],
 				       payload,
 				       payload_len);
-- 
2.34.1

