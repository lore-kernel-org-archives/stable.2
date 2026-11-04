Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799733;
	b=uN1LHHK1TmcH8Rgqb3ITHFG+Xw7ohK2hLQq//3zeA0NqbyXjPpuPYijZOVYCfmPMeonm
	 6comG3GPJK77JRTQcYhXjsnhCeVGRy1sBgTNFqYK6Vlfrt2GlVPwpHJgCqoM7g7EVrXUZ
	 wQ0ZrgPUncHBow2rDYV5XGBSxuwaJ7si+v6YvZiTr/vxerOjcSeSXI93EPRtRM9TYUoID
	 3FKpwjY+Mj1JJ1zj1I2qbGGjY/6mZXlJ58VQUG/uNkRBACOv9bJecRs57EIV327LNtQdt
	 WLvONvT1Eb1o7lWQ/xz2GpldtEN4T39dRzg3/7/9hcziTvmJIikOnWNxcWHIaIM9yYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799733;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0JIHzFag6xeRu3L2dLFmznluPaSKXAu3TNo93fnc1Hc=;
	b=m4j0Oaam6PFjYKbyiKxqhR+mvWqQeb0zDIifMDCQXO0QIiYJGJO6KzHLis5krrTTmpdh
	 yLD0D7o/24FXnwKI/hV7ohjOsW+r4dh5+F/pOryKeBPT0KeetUWfFKolTepSiu4O1st3D
	 5FEqDh1uQRbcYjlwPQv6LurAp2vvikTCq48UTzEWY1P8xnwtn62mdBNvLpJArYwOdKsfp
	 rrfc4v/ooUFIKpvvvPcKOPh48hQrxf1VaUDsQIJWtfMFY8bhcNoq6z1azngEJqtfCjZgt
	 ioShKYRTYJCxFnWgC1ZdD8ZkMseb13nWT5fpIHps1Uyon8mtaWwpho28pSMRWNeAEzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zlp+HDg5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD438606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zlp+HDg5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689361F000C1;
	Wed,  4 Nov 2026 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799732;
	bh=0JIHzFag6xeRu3L2dLFmznluPaSKXAu3TNo93fnc1Hc=;
	h=Subject:To:Cc:From:Date;
	b=zlp+HDg5tWlmMARiHrRvPrvQlAvrPxqJcu/ZkSlzeoBEvQS/F8sryX9GMCThAGUH/
	 C2cNuocXcSnMbyfHUz7vJU9nusa3px5ZMqkgDOV1+bqK6hRE28oLw6IiNqi52qDu4K
	 M1UlQFGUaHMaFWkv7xq+L+eDzd0eJpjz8e131dxA=
Subject: FAILED: patch "[PATCH] s390/zcrypt: Fix and improve zcrypt reply message" failed to apply to 6.12-stable tree
To: freude@linux.ibm.com,dengler@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:42:08 +0100
Message-ID: <2026110408-refute-dislodge-399b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5e9b339f323216d71f3ede8a0a427abf7859c486
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110408-refute-dislodge-399b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e9b339f323216d71f3ede8a0a427abf7859c486 Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Fri, 2 Oct 2026 12:52:36 +0200
Subject: [PATCH] s390/zcrypt: Fix and improve zcrypt reply message
 verification checks

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA, EP11 (AP message
type 6) and ICA (AP type 50) messages. The verification code related
to reply field length was not designed well and thus firmware
deficiencies could lead to unexpected behavior in the zcrypt device
driver. Thus improve the code to more closely inspect especially
length fields at message replies.

Add length validation before accessing reply message structures in
zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11(), and
zcrypt_msgtype50_receive() to prevent out-of-bounds reads and
potential kernel memory disclosure.

Also rework these three functions to validate reply lengths more
carefully before copying data back into the request buffer. Use size_t
for length calculations, reject inconsistent reply sizes, and add
defensive handling for short invalid replies. For XCRB replies,
validate both reply segments and derive the effective message length
from the covered range instead of trusting only the second segment.

Additionally improve some of the later invoked evaluation functions
which further check the payload. Add comments about length assumptions
and for the type50 processing rework the payload processing completely
with removing a misplaced BUG_ON().

Fixes: 5e55a488c87a ("s390/zcrypt: Separate msgtype implementation from card modules.")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index d6fc2d8e7fad..5907fb2a6920 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -152,6 +152,11 @@ struct type80_hdr {
 	unsigned char	reserved3[8];
 } __packed;
 
+struct type80_reply {
+	struct type80_hdr hdr;
+	char data[];
+} __packed;
+
 int get_rsa_modex_fc(struct ica_rsa_modexpo *mex, int *fcode)
 {
 	if (!mex->inputdatalength)
@@ -340,32 +345,43 @@ static int ICACRT_msg_to_type50CRT_msg(struct zcrypt_queue *zq,
  * @data: pointer to user output data
  * @length: size of user output data
  *
- * Returns 0 on success or -EFAULT.
+ * Returns 0 on success or neg. errno value on failure.
  */
 static int convert_type80(struct zcrypt_queue *zq,
 			  struct ap_message *reply,
 			  char __user *outputdata,
 			  unsigned int outputdatalength)
 {
-	struct type80_hdr *t80h = reply->msg;
-	unsigned char *data;
+	struct type80_reply *msg = reply->msg;
+	size_t payload_len;
 
-	if (t80h->len < sizeof(*t80h) + outputdatalength) {
-		/* The result is too short, the CEXxA card may not do that.. */
+	/*
+	 * reply->len is always >= sizeof(struct type80_reply) here and
+	 * outputdatalength (the modulus size) is guaranteed to be equal to
+	 * inputdatalength and 0 < outputdatalength <= CEX3A_MAX_MOD_SIZE,
+	 * also payload size may be >= outputdatalength.
+	 */
+
+	payload_len = reply->len - sizeof(msg->hdr);
+
+	if (outputdatalength > payload_len) {
+		/* We expect at least outputdatalength bytes, broken card ? */
 		zq->online = 0;
 		pr_err("Crypto dev=%02x.%04x code=0x%02x => online=0 rc=EAGAIN\n",
 		       AP_QID_CARD(zq->queue->qid),
-		       AP_QID_QUEUE(zq->queue->qid), t80h->code);
+		       AP_QID_QUEUE(zq->queue->qid), msg->hdr.code);
 		ZCRYPT_DBF_ERR("%s dev=%02x.%04x code=0x%02x => online=0 rc=EAGAIN\n",
 			       __func__, AP_QID_CARD(zq->queue->qid),
-			       AP_QID_QUEUE(zq->queue->qid), t80h->code);
+			       AP_QID_QUEUE(zq->queue->qid), msg->hdr.code);
 		ap_send_online_uevent(&zq->queue->ap_dev, zq->online);
 		return -EAGAIN;
 	}
-	BUG_ON(t80h->len > CEX3A_MAX_RESPONSE_SIZE);
-	data = reply->msg + t80h->len - outputdatalength;
-	if (copy_to_user(outputdata, data, outputdatalength))
+
+	if (copy_to_user(outputdata,
+			 msg->data + payload_len - outputdatalength,
+			 outputdatalength))
 		return -EFAULT;
+
 	return 0;
 }
 
@@ -374,14 +390,19 @@ static int convert_response(struct zcrypt_queue *zq,
 			    char __user *outputdata,
 			    unsigned int outputdatalength)
 {
-	/* Response type byte is the second byte in the response. */
-	unsigned char rtype = ((unsigned char *)reply->msg)[1];
+	struct type80_reply *msg = reply->msg;
 
-	switch (rtype) {
+	/* reply->len is always >= sizeof(struct error_hdr) here */
+
+	switch (msg->hdr.type) {
 	case TYPE82_RSP_CODE:
 	case TYPE88_RSP_CODE:
 		return convert_error(zq, reply);
 	case TYPE80_RSP_CODE:
+		if (msg->hdr.code)
+			return convert_error(zq, reply);
+		if (reply->len < sizeof(struct type80_reply))
+			return -EINVAL;
 		return convert_type80(zq, reply,
 				      outputdata, outputdatalength);
 	default: /* Unknown response type, this should NEVER EVER happen */
@@ -389,11 +410,11 @@ static int convert_response(struct zcrypt_queue *zq,
 		pr_err("Crypto dev=%02x.%04x unknown response type 0x%02x => online=0 rc=EAGAIN\n",
 		       AP_QID_CARD(zq->queue->qid),
 		       AP_QID_QUEUE(zq->queue->qid),
-		       (int)rtype);
+		       (int)msg->hdr.type);
 		ZCRYPT_DBF_ERR(
 			"%s dev=%02x.%04x unknown response type 0x%02x => online=0 rc=EAGAIN\n",
 			__func__, AP_QID_CARD(zq->queue->qid),
-			AP_QID_QUEUE(zq->queue->qid), (int)rtype);
+			AP_QID_QUEUE(zq->queue->qid), (int)msg->hdr.type);
 		ap_send_online_uevent(&zq->queue->ap_dev, zq->online);
 		return -EAGAIN;
 	}
@@ -416,26 +437,46 @@ static void zcrypt_msgtype50_receive(struct ap_queue *aq,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
 	struct type80_hdr *t80h;
-	int len;
+	size_t len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
 		goto out;	/* ap_msg->rc indicates the error */
+
 	t80h = reply->msg;
-	if (t80h->type == TYPE80_RSP_CODE) {
-		len = t80h->len;
-		if (len > reply->bufsize || len > msg->bufsize ||
-		    len != reply->len) {
-			pr_debug("len mismatch => EMSGSIZE\n");
-			msg->rc = -EMSGSIZE;
+
+	if (reply->len < sizeof(*t80h) ||
+	    t80h->type != TYPE80_RSP_CODE) {
+		if (reply->len < sizeof(error_reply)) {
+			/* total broken reply, use static error reply instead */
+			memcpy(msg->msg, &error_reply, sizeof(error_reply));
+			msg->len = sizeof(error_reply);
 			goto out;
+		} else {
+			/* malformed reply, convert function will handle this */
+			len = reply->len;
+			goto copy_len_and_out;
 		}
-		memcpy(msg->msg, reply->msg, len);
-		msg->len = len;
-	} else {
-		memcpy(msg->msg, reply->msg, sizeof(error_reply));
-		msg->len = sizeof(error_reply);
 	}
+
+	len = t80h->len;
+
+copy_len_and_out:
+	if (len != reply->len) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu rpl.len %zu mismatch, msg.rc=%d\n",
+			 len, reply->len, msg->rc);
+		goto out;
+	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu exceeds buf %zu/%zu, msg.rc=%d\n",
+			 len, reply->bufsize, msg->bufsize, msg->rc);
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&msg->response.work);
 }
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 3df1d676de5d..5962224bfb8b 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -766,6 +766,15 @@ static int convert_type86_rng(struct zcrypt_queue *zq,
 
 	if (msg->cprbx.ccp_rtcode != 0 || msg->cprbx.ccp_rscode != 0)
 		return -EINVAL;
+	/*
+	 * Note that offset2 and count2 have already been checked in
+	 * zcrypt_msgtype6_receive(). So only check for valid count2
+	 * and for not exceeding the hard coded rng buffer size.
+	 */
+	if (!msg->fmt2.count2)
+		return -EINVAL;
+	if (msg->fmt2.count2 > ZCRYPT_RNG_BUFFER_SIZE)
+		return -EMSGSIZE;
 	memcpy(buffer, data + msg->fmt2.offset2, msg->fmt2.count2);
 	return msg->fmt2.count2;
 }
@@ -777,11 +786,17 @@ static int convert_response_ica(struct zcrypt_queue *zq,
 {
 	struct type86x_reply *msg = reply->msg;
 
+	/* reply->len is always >= sizeof(struct error_hdr) here */
+
 	switch (msg->hdr.type) {
 	case TYPE82_RSP_CODE:
 	case TYPE88_RSP_CODE:
 		return convert_error(zq, reply);
 	case TYPE86_RSP_CODE:
+		if (msg->hdr.reply_code)
+			return convert_error(zq, reply);
+		if (reply->len < sizeof(struct type86x_reply))
+			return -EINVAL;
 		if (msg->cprbx.ccp_rtcode &&
 		    msg->cprbx.ccp_rscode == 0x14f &&
 		    outputdatalength > 256) {
@@ -792,8 +807,6 @@ static int convert_response_ica(struct zcrypt_queue *zq,
 				return -EINVAL;
 			}
 		}
-		if (msg->hdr.reply_code)
-			return convert_error(zq, reply);
 		if (msg->cprbx.cprb_ver_id == 0x02)
 			return convert_type86_ica(zq, reply,
 						  outputdata, outputdatalength);
@@ -820,6 +833,8 @@ static int convert_response_xcrb(bool userspace, struct zcrypt_queue *zq,
 {
 	struct type86x_reply *msg = reply->msg;
 
+	/* reply->len is always >= sizeof(struct error_hdr) here */
+
 	switch (msg->hdr.type) {
 	case TYPE82_RSP_CODE:
 	case TYPE88_RSP_CODE:
@@ -827,9 +842,16 @@ static int convert_response_xcrb(bool userspace, struct zcrypt_queue *zq,
 		return convert_error(zq, reply);
 	case TYPE86_RSP_CODE:
 		if (msg->hdr.reply_code) {
-			xcrb->status = msg->fmt2.apfs;
+			if (reply->len < sizeof(struct type86_fmt2_msg))
+				xcrb->status = 0x0008044DL;
+			else
+				xcrb->status = msg->fmt2.apfs;
 			return convert_error(zq, reply);
 		}
+		if (reply->len < sizeof(struct type86_fmt2_msg) +
+		    offsetof(struct CPRBX, cprb_ver_id) +
+		    sizeof(msg->cprbx.cprb_ver_id))
+			return -EINVAL;
 		if (msg->cprbx.cprb_ver_id == 0x02)
 			return convert_type86_xcrb(userspace, zq, reply, xcrb);
 		fallthrough;	/* wrong cprb version is an unknown response */
@@ -854,6 +876,8 @@ static int convert_response_ep11_xcrb(bool userspace, struct zcrypt_queue *zq,
 {
 	struct type86_ep11_reply *msg = reply->msg;
 
+	/* reply->len is always >= sizeof(struct error_hdr) here */
+
 	switch (msg->hdr.type) {
 	case TYPE82_RSP_CODE:
 	case TYPE87_RSP_CODE:
@@ -861,6 +885,8 @@ static int convert_response_ep11_xcrb(bool userspace, struct zcrypt_queue *zq,
 	case TYPE86_RSP_CODE:
 		if (msg->hdr.reply_code)
 			return convert_error(zq, reply);
+		if (reply->len < sizeof(struct type86_ep11_reply))
+			return -EINVAL;
 		if (msg->cprbx.cprb_ver_id == 0x04)
 			return convert_type86_ep11_xcrb(userspace, zq, reply, xcrb);
 		fallthrough;	/* wrong cprb version is an unknown resp */
@@ -885,6 +911,8 @@ static int convert_response_rng(struct zcrypt_queue *zq,
 {
 	struct type86x_reply *msg = reply->msg;
 
+	/* reply->len is always >= sizeof(struct error_hdr) here */
+
 	switch (msg->hdr.type) {
 	case TYPE82_RSP_CODE:
 	case TYPE88_RSP_CODE:
@@ -892,6 +920,8 @@ static int convert_response_rng(struct zcrypt_queue *zq,
 	case TYPE86_RSP_CODE:
 		if (msg->hdr.reply_code)
 			return -EINVAL;
+		if (reply->len < sizeof(struct type86x_reply))
+			return -EINVAL;
 		if (msg->cprbx.cprb_ver_id == 0x02)
 			return convert_type86_rng(zq, reply, data);
 		fallthrough;	/* wrong cprb version is an unknown response */
@@ -928,48 +958,85 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86x_reply *t86r;
-	int len;
+	size_t minlen, len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
 		goto out;	/* ap_msg->rc indicates the error */
+
 	t86r = reply->msg;
-	if (t86r->hdr.type == TYPE86_RSP_CODE &&
-	    t86r->cprbx.cprb_ver_id == 0x02) {
-		switch (resp_type->type) {
-		case CEXXC_RESPONSE_TYPE_ICA:
-			len = sizeof(struct type86x_reply) + t86r->length;
-			if (len > reply->bufsize || len > msg->bufsize ||
-			    len != reply->len) {
-				pr_debug("len mismatch => EMSGSIZE\n");
-				msg->rc = -EMSGSIZE;
-				goto out;
-			}
-			memcpy(msg->msg, reply->msg, len);
-			msg->len = len;
-			break;
-		case CEXXC_RESPONSE_TYPE_XCRB:
-			if (t86r->fmt2.count2)
-				len = t86r->fmt2.offset2 + t86r->fmt2.count2;
-			else
-				len = t86r->fmt2.offset1 + t86r->fmt2.count1;
-			if (len > reply->bufsize || len > msg->bufsize ||
-			    len != reply->len) {
-				pr_debug("len mismatch => EMSGSIZE\n");
-				msg->rc = -EMSGSIZE;
-				goto out;
-			}
-			memcpy(msg->msg, reply->msg, len);
-			msg->len = len;
-			break;
-		default:
+	minlen = sizeof(t86r->hdr) + sizeof(t86r->fmt2) +
+		offsetof(struct CPRBX, cprb_ver_id) +
+		sizeof(t86r->cprbx.cprb_ver_id);
+
+	if (reply->len < minlen ||
+	    t86r->hdr.type != TYPE86_RSP_CODE ||
+	    t86r->cprbx.cprb_ver_id != 0x02) {
+		if (reply->len < sizeof(error_reply)) {
+			/* total broken reply, use static error reply instead */
 			memcpy(msg->msg, &error_reply, sizeof(error_reply));
 			msg->len = sizeof(error_reply);
+			goto out;
+		} else {
+			/* malformed reply, convert function will handle this */
+			len = reply->len;
+			goto copy_len_and_out;
 		}
-	} else {
-		memcpy(msg->msg, reply->msg, sizeof(error_reply));
-		msg->len = sizeof(error_reply);
 	}
+
+	switch (resp_type->type) {
+	case CEXXC_RESPONSE_TYPE_ICA:
+		if (reply->len < sizeof(struct type86x_reply)) {
+			msg->rc = -EMSGSIZE;
+			pr_debug("rpl.len %zu < struct type86_reply, msg.rc=%d\n",
+				 reply->len, msg->rc);
+			goto out;
+		}
+		len = sizeof(struct type86x_reply) + (size_t)t86r->length;
+		break;
+	case CEXXC_RESPONSE_TYPE_XCRB:
+		len = (size_t)t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
+		if (len > reply->len) {
+			msg->rc = -EMSGSIZE;
+			pr_debug("offset1 %u count1 %u rpl.len %zu mismatch, msg.rc=%d\n",
+				 t86r->fmt2.offset1, t86r->fmt2.count1,
+				 reply->len, msg->rc);
+			goto out;
+		}
+		if (t86r->fmt2.count2) {
+			len = (size_t)t86r->fmt2.offset2 +
+				(size_t)t86r->fmt2.count2;
+			if (len > reply->len) {
+				msg->rc = -EMSGSIZE;
+				pr_debug("offset2 %u count2 %u rpl.len %zu mismatch, msg.rc=%d\n",
+					 t86r->fmt2.offset2, t86r->fmt2.count2,
+					 reply->len, msg->rc);
+				goto out;
+			}
+		}
+		break;
+	default:
+		memcpy(msg->msg, &error_reply, sizeof(error_reply));
+		msg->len = sizeof(error_reply);
+		goto out;
+	}
+
+copy_len_and_out:
+	if (len != reply->len) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu rpl.len %zu mismatch, msg.rc=%d\n",
+			 len, reply->len, msg->rc);
+		goto out;
+	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu exceeds buf %zu/%zu, msg.rc=%d\n",
+			 len, reply->bufsize, msg->bufsize, msg->rc);
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&resp_type->work);
 }
@@ -992,34 +1059,65 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86_ep11_reply *t86r;
-	int len;
+	size_t minlen, len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
 		goto out;	/* ap_msg->rc indicates the error */
+
 	t86r = reply->msg;
-	if (t86r->hdr.type == TYPE86_RSP_CODE &&
-	    t86r->cprbx.cprb_ver_id == 0x04) {
-		switch (resp_type->type) {
-		case CEXXC_RESPONSE_TYPE_EP11:
-			len = t86r->fmt2.offset1 + t86r->fmt2.count1;
-			if (len > reply->bufsize || len > msg->bufsize ||
-			    len != reply->len) {
-				pr_debug("len mismatch => EMSGSIZE\n");
-				msg->rc = -EMSGSIZE;
-				goto out;
-			}
-			memcpy(msg->msg, reply->msg, len);
-			msg->len = len;
-			break;
-		default:
+	minlen = sizeof(t86r->hdr) + sizeof(t86r->fmt2) +
+		offsetof(struct ep11_cprb, cprb_ver_id) +
+		sizeof(t86r->cprbx.cprb_ver_id);
+
+	if (reply->len < minlen ||
+	    t86r->hdr.type != TYPE86_RSP_CODE ||
+	    t86r->cprbx.cprb_ver_id != 0x04) {
+		if (reply->len < sizeof(error_reply)) {
+			/* total broken reply, use static error reply instead */
 			memcpy(msg->msg, &error_reply, sizeof(error_reply));
 			msg->len = sizeof(error_reply);
+			goto out;
+		} else {
+			/* malformed reply, convert function will handle this */
+			len = reply->len;
+			goto copy_len_and_out;
 		}
-	} else {
-		memcpy(msg->msg, reply->msg, sizeof(error_reply));
-		msg->len = sizeof(error_reply);
 	}
+
+	switch (resp_type->type) {
+	case CEXXC_RESPONSE_TYPE_EP11:
+		len = (size_t)t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
+		if (len > reply->len) {
+			msg->rc = -EMSGSIZE;
+			pr_debug("offset1 %u count1 %u rpl.len %zu mismatch, msg.rc=%d\n",
+				 t86r->fmt2.offset1, t86r->fmt2.count1,
+				 reply->len, msg->rc);
+			goto out;
+		}
+		break;
+	default:
+		memcpy(msg->msg, &error_reply, sizeof(error_reply));
+		msg->len = sizeof(error_reply);
+		goto out;
+	}
+
+copy_len_and_out:
+	if (len != reply->len) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu rpl.len %zu mismatch, msg.rc=%d\n",
+			 len, reply->len, msg->rc);
+		goto out;
+	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu exceeds buf %zu/%zu, msg.rc=%d\n",
+			 len, reply->bufsize, msg->bufsize, msg->rc);
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&resp_type->work);
 }

