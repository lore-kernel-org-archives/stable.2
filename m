Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739D23909C
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781985404; cv=none; b=GOppBEETZgTTZ8RbSrHT0W0/UOErIiWL4aRSHLSBPeGC74g5uzrri8QEetomI9VvPHZxG6xz9cOFqybZ/p3XzXYVcK8DwCk6GsgX+2MOQXANNHGkzxQChTxV7fKcygTFPXP0U+T+MpUDvwB5h1VdtM8WVkIuDeYMV7omtKVrxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781985404; c=relaxed/simple;
	bh=ia2k/wHGStLnbUdWS4cpoTTCfNT3fsXLA1/H0pS+0qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WnLcld92mdJrrt8ddoJfC+TijfG9uxxnM82cC+Ku0aHp1xwJIe1V5hLaAyhu1wpKi0tRyxmDVbji8DU5GcjmfH/gI8eiQWxbuKniKTJRTO6xyLrZmk3mRvW6sIdE+R2nQDAxApzPgwXzmfmTC22twbEqfiwPMfRjtHUiP9iHC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQlJrDz8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQlJrDz8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso18107715e9.2
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 12:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781985401; x=1782590201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNUgrgcq1AYSvYY2c3ajuQ9N2i3vFsvAI4lXgF2Mko8=;
        b=DQlJrDz8ILfaM+meV8b6L6SAxa2PIbKRzesqysY33ODD5aHH6Sm+T39U62F1zdeZ64
         MjqTkh4YjybfIFTlqypTSpuGnhtlfgjoWoAN7wYi0/MB9FpqxrB0/j0hEm1+JjYm+FoC
         KouV0zikCTPS9nwjmVYMERpXV6NZMVS4Qn86wKycKMMwhkF5OLUMJC6iWyGcYYZpWn4L
         hlUsGXzuT5vbALhCIVPEgokStJLCJREaXAVXr2ubKIzFvh//eGqSMt+ciGx1OHDcPEYR
         iWHB0vONYkih3blfhTrPe3VmjOkt/XCvp/uAsJ0ogac/PxwTd9+uUOth4YesRlh9iRPR
         nHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781985401; x=1782590201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNUgrgcq1AYSvYY2c3ajuQ9N2i3vFsvAI4lXgF2Mko8=;
        b=RfOlu9xpEBd43Jesf8HgtfK1giJbRpCXg/YfsijuIZfZ+rAJNCOfnKqDBwi9Bu8FvV
         YgevfcsOWMpC0qotzYToKcyHP/BMgXHPkhSut72j7cihwXk7rsLpQszgH6dBfqRENrmF
         sABOfbyl18l323WNNfNqzlxPl+m43SHQp04RdI1ACJ/J+7eEg6eIT+1Gaas4FHDowO5G
         HqXMVtLrnrGJ6wrBM8p3lDuNUA6sKNkaDMC3+P32KQPkM/FlaNwnCOhAqG8rm5NQm9EF
         BzkCeH+ovWHC6HXOvSdBpnRRC3PkNG4Sd/MEkP1rWVSh6pqtNbrnl7JY2PESKMrgwtTI
         iQMg==
X-Forwarded-Encrypted: i=1; AFNElJ/d6oie0ZRX4B7BfZkGCkz1CIWBMO4jKB8fHVLBdTVSVngZTt9423VmyWMinJW9Vuziyn1s03Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEJio36m4sczJAnOXUdCtCVMkSQcRZ9SJVGthkF9TREOzZ14/
	LeYAmRQBJ6MXfq5M3wohiGg5VUiuqQ+A6YQnHBYMMRetJr/Y5GOOzpGg
X-Gm-Gg: AfdE7cmHwYlKY5K9QHRYB7VZdBIPcqxXrA1AbjznHXl+L1YQKqviMDcm+VaLrsG3N+E
	dA//vp2M0z+Ku9j+n77dNwcdVnHHaTZ1CO7SPG6CwbTUvBo/y/TcMAaMCJMdCO73LXF72Prp3Wk
	+X0w0Mdc23QhIE7MhZKttHuyRA/zEdOYbbQdXNlGhdDZy0hUIqO7Bv8ZvYx/a0PJjaUpppMVj5h
	4OCzo6RI19n/LpC4EfxRwEcVNrQ9nmlwkCtrmHhGXsCqASzRzV8Ebmc7wE+m+R61lfiZec+vWzX
	EO/vjCReL+hBUlo95n8TnqU2B0SvPNVX+NhAFudlVL5RMJmlfHBFI064HpbzbBGQK4Nyc/0uL98
	JhWTR6xFRIefIsR/qUgJWpV0ByIwiMA3rgDPmFJswtf/DCjWr5XlLM7EkgeLH9K65BQtxfQwtXx
	qmez9CxvvR51DUFRpI78E/ZSueIY5mjI1ZZi/YvDff16w6l5N4hLZmx5SLmcpVfUE=
X-Received: by 2002:a05:600c:2305:b0:492:2f59:4969 with SMTP id 5b1f17b1804b1-49240e5b469mr105749115e9.22.1781985400840;
        Sat, 20 Jun 2026 12:56:40 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667881b4sm9853358f8f.24.2026.06.20.12.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 12:56:40 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: validate option length before reading conf opt value
Date: Sun, 21 Jun 2026 00:56:35 +0500
Message-ID: <20260620195635.41765-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_get_conf_opt() derives the option length from the
attacker-controlled opt->len field and immediately dereferences
opt->val (as u8, get_unaligned_le16() or get_unaligned_le32(), or a
raw pointer for the default case) before any caller has confirmed
that opt->len bytes are present in the buffer. The callers
(l2cap_parse_conf_req(), l2cap_parse_conf_rsp() and
l2cap_conf_rfc_get()) only detect a malformed option afterwards, once
the running length has gone negative, by which point the
out-of-bounds read has already executed.

An existing post-hoc length check keeps the garbage value from being
consumed, so this is not a data leak in the current control flow. It
is still a validate-after-use ordering bug: up to 4 bytes are read
past the end of the buffer before it is known to contain them, and it
is fragile to future changes in the callers.

Fix it at the source. Pass the end of the buffer into
l2cap_get_conf_opt() and refuse to touch opt->val unless the full
option (header + value) fits. Each caller computes an end pointer
once before the loop and checks the return value directly instead of
inferring the error from a negative length.

Fixes: 7c9cbd0b5e38 ("Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/l2cap_core.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4ccfbda9d789..ebe44990a22e2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3052,13 +3052,24 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn, u8 code,
 	return NULL;
 }
 
-static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen,
-				     unsigned long *val)
+static inline int l2cap_get_conf_opt(void **ptr, void *end, int *type,
+				     int *olen, unsigned long *val)
 {
 	struct l2cap_conf_opt *opt = *ptr;
 	int len;
 
+	/* opt->len is attacker-controlled. Validate that the full option
+	 * (header + value) actually fits in the buffer before touching
+	 * opt->val, otherwise the switch below reads past the end of the
+	 * caller's buffer.
+	 */
+	if (end - *ptr < L2CAP_CONF_OPT_SIZE)
+		return -EINVAL;
+
 	len = L2CAP_CONF_OPT_SIZE + opt->len;
+	if (end - *ptr < len)
+		return -EINVAL;
+
 	*ptr += len;
 
 	*type = opt->type;
@@ -3426,6 +3437,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	void *ptr = rsp->data;
 	void *endptr = data + data_size;
 	void *req = chan->conf_req;
+	void *req_end = req + chan->conf_len;
 	int len = chan->conf_len;
 	int type, hint, olen;
 	unsigned long val;
@@ -3439,9 +3451,11 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	BT_DBG("chan %p", chan);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
-		if (len < 0)
+		int ret = l2cap_get_conf_opt(&req, req_end, &type, &olen, &val);
+
+		if (ret < 0)
 			break;
+		len -= ret;
 
 		hint  = type & L2CAP_CONF_HINT;
 		type &= L2CAP_CONF_MASK;
@@ -3669,6 +3683,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	struct l2cap_conf_req *req = data;
 	void *ptr = req->data;
 	void *endptr = data + size;
+	void *rsp_end = rsp + len;
 	int type, olen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
@@ -3677,9 +3692,11 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
-		if (len < 0)
+		int ret = l2cap_get_conf_opt(&rsp, rsp_end, &type, &olen, &val);
+
+		if (ret < 0)
 			break;
+		len -= ret;
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
@@ -3930,6 +3947,7 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 {
 	int type, olen;
 	unsigned long val;
+	void *rsp_end = rsp + len;
 	/* Use sane default values in case a misbehaving remote device
 	 * did not send an RFC or extended window size option.
 	 */
@@ -3948,9 +3966,11 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 		return;
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
-		if (len < 0)
+		int ret = l2cap_get_conf_opt(&rsp, rsp_end, &type, &olen, &val);
+
+		if (ret < 0)
 			break;
+		len -= ret;
 
 		switch (type) {
 		case L2CAP_CONF_RFC:
-- 
2.54.0

