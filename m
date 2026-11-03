Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702876;
	b=nclot8rG/pRIdMGoV2orWQTC+KqxmTQV2i/Mrg2/0V5ULgMvBN5NcSqxA5B1vdJWT88X
	 zilT+WYLN0U2iccoZnedcEq7WuXReF4oHHiStzb5i4WBC/tfHzn35mK1clpOfv4B1A4jV
	 Z6ap8BQeaqQrF9i2F8h3qWTJI91I3M0EAHf3DUjOmbSE+pLE7+lUGf0pQXbW2+/jtwBTn
	 jtul1C7SN9jbnDzpJ1F2ugXbBP7x47JqJPfEKVANlfxzbQncmKsCVIOnieF/G74kxN6vD
	 GOIWfCOb/ay1MDgZRfyQIG4mH1qQoxd/JQ64znuT0nqbbbG7UR3bWaCr8IbrvBu+7NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702876;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZMVjNwQz7HE0PKNntQGDOZ0+SFjkLEB/cWj8XAK3BWw=;
	b=qPnHno84Li1H8UNcwkr5xuNxi2U+vXa8DiiZJ7AlJ0SITKm8ajbAYk01ChBq2NhYRzcW
	 668MvVeXK9jII2KlxjVA9YFufLlYBeNtCRugHU6BwXf4JpzVStiesW4sG4LtxthrTMZj1
	 WIjhT8KTdZtbOcGkKcD7CS8ud7/6IOoRq0rPFbSb2Lpl4WSvN9bUWaRYMgvUDAZhTckb3
	 JSR3QhnGRAUPHVoW1EJWVpcfJqLDuZv06nh33VUpihqPVop5jm9MKm+PMAj6hPPH+0fGX
	 RElnPPECn8Fin5VUrbguH6eh8cBCpVYOaL+B2isE2geVbe1dRhbyOFIObrc9V/+Si+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W0CA4YIJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CD607378D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W0CA4YIJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554A41F00A1D;
	Tue,  3 Nov 2026 10:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793702875;
	bh=ZMVjNwQz7HE0PKNntQGDOZ0+SFjkLEB/cWj8XAK3BWw=;
	h=Subject:To:Cc:From:Date;
	b=W0CA4YIJ0jCflMU9lXQrrZoL28WfBpvcd4jXf45azLDnZRx0fxV8C/g7ox0us96G7
	 o9eCzdookkVj/qdnMVwbho8KsFuAqeE7Tv6Zkc+jpNJQ6n5/x8cnsZiq3Lp8/HrxR0
	 a4cWCAPDJM8+aiZQSVUs6SeI8J1O6mU5UKZtmhUo=
Subject: FAILED: patch "[PATCH] ksmbd: verify transform SessionId matches the decrypted" failed to apply to 6.6-stable tree
To: zhangdairui@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:46:44 +0100
Message-ID: <2026110344-unguarded-nimble-eff6@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 798214e6fafcdcc29f5ba2661a473232b5e70cfb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110344-unguarded-nimble-eff6@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 798214e6fafcdcc29f5ba2661a473232b5e70cfb Mon Sep 17 00:00:00 2001
From: Dairui Zhang <zhangdairui@gmail.com>
Date: Tue, 29 Sep 2026 22:30:00 +0800
Subject: [PATCH] ksmbd: verify transform SessionId matches the decrypted
 header

When an encrypted request comes in, the decryption key is picked by
the SessionId in the transform header, but the request is then
authorized under whatever session the decrypted inner header names.
Nothing ever compares the two, so on a connection with more than
one session a client can get a request decrypted with one session's
key and run it as another session. Encrypted requests are exempt
from signing too, so a valid AEAD tag is the only proof of session
identity, and it is checked against the wrong session.

MS-SMB2 says the server must check that the transform SessionId
matches the one in the decrypted SMB2 header and treat a mismatch
as a protocol error. Add that check in __handle_ksmbd_work() after
decryption, before dispatching: the message has to be at least one
fixed SMB2 header, the first operation must not set
SMB2_FLAGS_RELATED_OPERATIONS and its SessionId must match the
transform SessionId, and every following non-related operation in
a compound chain must carry the same SessionId. NextCommand
offsets must be 8-byte aligned and stay inside the message; the
bounds check is done by subtraction so it cannot wrap.

When the decrypted payload is a compression transform, the
existing decompression step runs first and the decompressed SMB2
message is checked instead, since a compression transform header
carries no SessionId.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Reported-by: Dairui Zhang <zhangdairui@gmail.com>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 0827c8c51006..eb2952f2debe 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -187,6 +187,16 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 
 	if (conn->ops->is_transform_hdr &&
 	    conn->ops->is_transform_hdr(work->request_buf)) {
+		u64 tr_sess_id;
+
+		if (get_rfc1002_len(work->request_buf) <
+		    sizeof(struct smb2_transform_hdr)) {
+			ksmbd_conn_abort(conn);
+			return;
+		}
+		tr_sess_id = le64_to_cpu(((struct smb2_transform_hdr *)
+				smb_get_msg(work->request_buf))->SessionId);
+
 		rc = conn->ops->decrypt_req(work);
 		if (rc < 0) {
 			ksmbd_conn_abort(conn);
@@ -215,6 +225,12 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 			ksmbd_conn_abort(conn);
 			return;
 		}
+
+		rc = ksmbd_check_transform_session(work, tr_sess_id);
+		if (rc < 0) {
+			ksmbd_conn_abort(conn);
+			return;
+		}
 	}
 
 	if (conn->ops->allocate_rsp_buf(work))
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 45dce9c30b6b..0592e2539d1d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -12256,6 +12256,60 @@ bool smb3_is_transform_hdr(void *buf)
 	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
 }
 
+/*
+ * The decryption key is selected by the transform SessionId, but
+ * the request is authorized under the session named in the
+ * decrypted SMB2 header. Per MS-SMB2 the two must match, so check
+ * the decrypted message and its compound chain before dispatch.
+ */
+int ksmbd_check_transform_session(struct ksmbd_work *work, u64 tr_sess_id)
+{
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
+	size_t msg_len = get_rfc1002_len(work->request_buf);
+	size_t off = 0;
+	bool first = true;
+
+	if (msg_len < sizeof(*hdr)) {
+		pr_err_ratelimited("Decrypted message is smaller than SMB2 header\n");
+		return -ECONNABORTED;
+	}
+
+	for (;;) {
+		u64 sid = le64_to_cpu(hdr->SessionId);
+		u32 next;
+
+		if (first) {
+			if (hdr->Flags & SMB2_FLAGS_RELATED_OPERATIONS) {
+				pr_err_ratelimited("RELATED_OPERATIONS set on first operation\n");
+				return -ECONNABORTED;
+			}
+			if (sid != tr_sess_id) {
+				pr_err_ratelimited("SessionId mismatch between transform and inner header\n");
+				return -ECONNABORTED;
+			}
+			first = false;
+		} else if (!(hdr->Flags & SMB2_FLAGS_RELATED_OPERATIONS) &&
+			   sid != tr_sess_id) {
+			pr_err_ratelimited("SessionId mismatch in compound chain\n");
+			return -ECONNABORTED;
+		}
+
+		next = le32_to_cpu(hdr->NextCommand);
+		if (!next)
+			return 0;
+		if (next % 8) {
+			pr_err_ratelimited("NextCommand %u is not 8-byte aligned\n", next);
+			return -ECONNABORTED;
+		}
+		if (next > msg_len - off - sizeof(*hdr)) {
+			pr_err_ratelimited("NextCommand %u is out of the message\n", next);
+			return -ECONNABORTED;
+		}
+		off += next;
+		hdr = (struct smb2_hdr *)((u8 *)smb_get_msg(work->request_buf) + off);
+	}
+}
+
 int smb3_decrypt_req(struct ksmbd_work *work)
 {
 	char *buf = work->request_buf;
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 40d61745ef41..c90a1d4e9f11 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -416,6 +416,7 @@ struct channel *lookup_chann_list(struct ksmbd_session *sess,
 void smb3_preauth_hash_rsp(struct ksmbd_work *work);
 bool smb3_is_transform_hdr(void *buf);
 int smb3_decrypt_req(struct ksmbd_work *work);
+int ksmbd_check_transform_session(struct ksmbd_work *work, u64 tr_sess_id);
 int smb3_encrypt_resp(struct ksmbd_work *work);
 bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work);
 int smb2_set_rsp_credits(struct ksmbd_work *work);

