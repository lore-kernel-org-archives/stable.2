Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426103;
	b=S9kZdTKVSIwxXLTOC9zqRgTWp6ePbyE7qy4CbU3HS0pV1pSFt3Td7AOuL7tNlJeFS+hU
	 ee6unYFmxyHOgA5kuNhNOKvrcSe+Tk5nlfZwuBcJAXN69OZJsTb8anx1/PfSsPubnwtJ/
	 88IqExctX6lC/FeP3SqEwzrV7s+WR1OWpDxfuGyl1VlugvijB5OTGFI6TJqy9ckJqi16R
	 NXBOhOqGWhtw27j0LInJXHcYtDOJaL9LJwdDyfImAPCc/h3/1LipAvKw0RRZ5CS1R6nV3
	 /BI6gnFKTRihL5FxEnK1s/gKdWW6MWHwvFEYO6u5MlVOoaNCM+Y/CX5bQMLny9a3KBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TyUSV4JaDgNRSYtJRC+X1tW6E6kq/VPnfDSZqIp7Hng=;
	b=l11eIjBBnzUN6GLXbJzo5E7w7McnjOZf0P1ej2gvS+rpOR4H8gnGKg+w0iX1foqnCJ39
	 dhI89ccutzfXkiHd/xD02aRqb7SYmpImSkHAh/o0KcPSPgNmvRkeRJbUF+fAPuZELQX+K
	 FNJSu7ydYX9ipzTvqK13/hXBNoHOiSPG3asqNMBXCVct3ROVPExbIS+ZYx7ls9zhR7O94
	 YGkoXt8pj5K8XCWKCZApv/omw893iIRFBo/vrvC6zvMFsjMoYMqsUGSd2/0wiieILFMr8
	 JE4JHl446aGa+kHFwdcjGRvz04jwjLHtSEAqelN8nnXwNdC7R7QuH3Zh6G4U4uiI5NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vh1JqURN;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA94606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA94606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vh1JqURN
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b244fb7fffso2793591c88.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426102; x=1796030902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TyUSV4JaDgNRSYtJRC+X1tW6E6kq/VPnfDSZqIp7Hng=;
        b=Vh1JqURN+B2yAQdew/k7C1Hh8rWgATD86Pyevt/0HEmVzKY177Qfi6Up08k/oFggI5
         VU8NCr5rwNKmTS/VkmR6sP2CM3aAIy069Wsom26cvUdnd5RcA8mNwUXXASlBvLwHEeTs
         hh739zuSEFQcSZq0Q7dM8b2Ak7i4X0PEHALeqosfzVW3uXuT4yCWtAi/H0Mcy49I6h5n
         xkK35GEsQPH8BEZnvJVJrg4U79hdbagSoenOnDoeWKEIKx7A8YRE0vhUDEO3ZvqVr/dQ
         XOXcXkzLyYsuBZXpM6unWH3kJpikapjjNuIVuQw8q1+UfXpwOpLSSccMyopDxM/2G/vs
         5wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426102; x=1796030902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TyUSV4JaDgNRSYtJRC+X1tW6E6kq/VPnfDSZqIp7Hng=;
        b=ef1jGVsfdYco0okv1R262T9kOlns+jbCXEvwP/BIsYjORqeEmJdnud1+a93pB9wPyj
         KgvtHVp4WhOOrD4PtiRo5wyLySl/rTTCm7gXyOBzP3r4Dt1ogT7Qn9dCHnzVB7DSA6is
         3/QYUtqeGJIbMJx5vG5jR4Q6cbZ5MsJi/FzfAnIQ4HG7O8hq0lO0zwETBz+0lM5GfjBv
         FzvOkpvhN7ODk+JNs88f+5aTv4TmdVvApnqmHCbFwCeueoPVdclo82asUQefjJZPLBT+
         2h8SysSU+Z6wNKA/nzovvUiuhqdWX+xJa3XEQ55bAgMacezuYWHneIzk59NJ9HRgahbv
         YM8g==
X-Forwarded-Encrypted: i=1; AL+hErGf8pO561wkliqCy3M2M2acFb8zws+x5Ae/KGxDv644Ma3NkTNjar1Ccl1STZBb/YEhpW2AqdU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JZmCZYEuzZQ64exZ4cKrpzDxwBOkqvci7A+p4pyTm6XZlclle
	Oz41fYFgr84LLMF/9W/jY6TPEbBGCsxfwnAxr8w0w4lP6wc6ef50aYmh
X-Gm-Gg: AZFdTZcAJkkeUXiJA0nhP3QCQ1hXTuPhPwSs7nos7tipo1HAA/l5Q/uK2XYoxEHZekX
	5Ocr/ZR+3nqz2v9UoZygssuRr7o5wbYW9YlBs8Z4vc3kVRCBrb/dtM3YdcPWL3k2NrnFV8QdT44
	V37nh2zToLoe+k6sN2P6+xO0ilH7sfEU2Vj/OMGYZS3jx8rCn4EwpLQZjVYnXvVfjSHPhrIH8jw
	Ee81v0fKAd42FqTpoVEv2Fa9cdtXqWVwtu6QOUL73OaNGubGF1CsgDQ5qm7vnUoskoutBEdHQ14
	yXR53DMZHUkvljVatGLJR07oPP6oleNvoih2KfgfgBvtNz5BN5f0vdutzqWA6S9NN4jxaHg4QnS
	jnPXg51ml3Q1SPwWLpuYLY03M9R0vd8uKPtJWMDTwPuQnWcpmWXn2IcuuVu0Uhvz8swVG/aRaey
	PlWRXchvxOSL2U8RTh7j2peMuzi0N6lnxi1KEg2cXugdpcS7R/WP6iTpbx+r3nYbx/LNJraf65X
	tzET39CQAyAEcAMzevZq1B8t2GXq0uBau7NYe+npeolTPbfoQJ7rjzaLyu5ym/Vrh4m0554H5ZQ
	g8CEgM1KQ8HOlb/ewVdH7F2E0ODK+Ooi4ZuEyjRkJm4Kytt3jJIU9FRI/EMaLVFJ0qxXfQgiyV4
	=
X-Received: by 2002:a05:7022:5e09:b0:1a0:b8f5:872d with SMTP id a92af1059eb24-1b5567c13a5mr10587992c88.4.1795426101890;
        Mon, 23 Nov 2026 01:28:21 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm19861941c88.11.2026.11.23.01.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:28:21 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] HID: intel-ish-hid: Reallocate the descriptor buffers for a longer response
Date: Mon, 23 Nov 2026 17:28:15 +0800
Message-Id: <20261123092816.2200718-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
References: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
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
second, longer response to one request does the same. After an empty
first response, the next copy writes at ZERO_SIZE_PTR.

Size the buffer to the received length with devm_krealloc() before the
copy.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer, which reports
none of these writes with this patch. Not tested on hardware, only
compile-tested with W=1 on hid.git for-7.4/upstream-fixes.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 21 ++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index ec5e8afe77bd..24f4032d6dfe 100644
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
@@ -172,11 +173,11 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
-			if (!client_data->hid_descr[curr_hid_dev])
-				client_data->hid_descr[curr_hid_dev] =
-				devm_kmalloc(cl_data_to_dev(client_data),
-					     payload_len, GFP_KERNEL);
-			if (client_data->hid_descr[curr_hid_dev]) {
+			descr = devm_krealloc(cl_data_to_dev(client_data),
+					      client_data->hid_descr[curr_hid_dev],
+					      payload_len, GFP_KERNEL);
+			if (descr) {
+				client_data->hid_descr[curr_hid_dev] = descr;
 				memcpy(client_data->hid_descr[curr_hid_dev],
 				       payload, payload_len);
 				client_data->hid_descr_size[curr_hid_dev] =
@@ -197,11 +198,11 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
-			if (!client_data->report_descr[curr_hid_dev])
-				client_data->report_descr[curr_hid_dev] =
-				devm_kmalloc(cl_data_to_dev(client_data),
-					     payload_len, GFP_KERNEL);
-			if (client_data->report_descr[curr_hid_dev])  {
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

