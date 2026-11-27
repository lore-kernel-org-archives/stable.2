Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795762073;
	b=cYawoHaceJYqRU3KzWRU0xogXtOED7bF2ovK4pCoyt7Hd/TIvIdzeEchGgMYU4Wf9181
	 Z7levCZJhIwaEYoiqpWPDZGPPoZ57GdRS5RLuMqw3fnl8aNKnUFuJrIOMHNc6o+iaYsaR
	 v7h7E+HbysFrFhL6aeQFjcUFnbx4IEkR53sUeQ+sf3b571LLQurTl0VO66U/8Qhfk4UXX
	 B2AyC/cPN9tbGT0hl46SSDX3NjV5SNrXy5aQe2Z1CUQkvrB7k63N2PteRD+z4U+WMKB0x
	 gT6rCGIKoTuFi1xOVWU5xUC/xI05VEstvWOVY4CY3bfNHrsWxRote8xdhEQNDmABw4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762073;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=TDuN97p1qoObocumuaAjgug87RFvc5TzoAa1x2CBtsM=;
	b=K2NfqDnJRImEk4spfKQWOVCiz6MnSiUaenI42Q9fWBH8hIu3q4zinQ2ogllhvPf5vV23
	 FPUyZF06vCGsGPKuWZiuTlvTHbsh6m1Tcf1/iyMx2FJfNVYpWF28llRE2P8bHPQG+PNke
	 TKZfycw4FhP0iO4Trkwl/fwIZzm1UdGtbMSgzu7wXa/yQBd9YCucC/AfM3JLaVVQUsOUs
	 W+mfuwgiW4vHjQ+ClmTZDATzneTNb9lrgtbVWj0GcOZ/t3jocX/jj5MHpEMLwKfa0m44C
	 QfPqvebxzwE/LJ40abwrY/yB1iamKXLfKYy7tyaDl3C/iia9ggOeD2/A2zEtNYfrN5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWo4Tvc3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCF606A31E;
	Fri, 27 Nov 2026 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWo4Tvc3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795762072;
	b=a1SY+zIusWQnjUmWbiNjgrJ5Dntc46EM9jKY48UWeOGOXDqxpmfNEG/ArcUo1D6bvfM3
	 5pmm/K7BBdUMjvp1OfEmmw2rLk5dqDUDQrw8TRCReFxyINeyu7c7n6o+MxugErOpGjnAP
	 4B5KPcsjT9ybIoo0OiOZbKeuzx54u1sU9Sl2n6JyoL4et7n+7YXDai47oyyqXYHGbOlZh
	 PrKdGP3BmuAS0t4idvBhGGfyP39aWUwZzrp4+NXqbJ+qHMXOC6vQj7xeTnPUTx+x4pc2l
	 IOQa5A+u6TwXguY7iLIf6FrTw9B003w8GCobjzVy0NoTPD32AWnuFxfVUZksDnROAoA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795762072;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=TDuN97p1qoObocumuaAjgug87RFvc5TzoAa1x2CBtsM=;
	b=u7Xk4S2TUjnrPwVdSNPI3iRNhiWi9NNHABJl9AswUT9WNC27Vddbj8uY4qwCGnu/QBX+
	 qCg0S/FWOa+n+klOK3Ddd3p1k1oerwAG3UdErQsqototA9jq9zLM/rjmZID++zwP7OTi1
	 QtSGkbc38xBUkL2LkgiP4t4YICgpNgM4G+Hu9S2KKfa/ZsgCoZhuhAlkKVXKaoMvrybdN
	 k1ZQTddPHRYnaEanF3F/oZUXZa7OPjT85KT0rdQcQWSErCA4wHdG6Kwtr9ecbaxxkX1Hx
	 rYFL9nfle0BmEWCxKHMsLlQgeUdZ59cWTDtSEeC3mMfYwflSVmciC52BTdYY4DGGi9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 07D971F0089F;
	Fri, 27 Nov 2026 06:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795762072;
	bh=TDuN97p1qoObocumuaAjgug87RFvc5TzoAa1x2CBtsM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=UWo4Tvc3uTrR/sCVHejamStQQGSlwBxDepF/cMzgTnvi1BOj043Lq4KkCjHGX/Hc+
	 gtQMMvFjSkST/OwFmF/TAyZle5F017CYsS0WTrQZld0n52Ve1kV8L6xcteg+zrqhIk
	 qA2gpjrb8vIhxoYiJaE589mFu/eUDXGmYHeu87mIsvewqnYFdjbL6PeKNqK7KjYWKv
	 /bwehuH+NF/XkvfyCIKF18cTOjt6wUlZ8gTglWROn2MfZc1Ril0jwho+L4PXlKqDB0
	 qgyaP5Ir1/ODvIJVwBnYSCl/YVYhZJ6cZ5LZa231Kki/TOXCOT/1hoPP2xMAjzIkjV
	 OBupyJrrHeu3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 855A64B5D0;
	Fri, 27 Nov 2026 06:47:46 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 06:22:13 +0000
Subject: [PATCH 5.10.y] binfmt_misc: restore write access before closing
 files opened by open_exec()
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-so5-binfmt-510-v1-1-c62790b381f0@certik.com>
X-B4-Tracking: v=1; b=H4sIAJQhCWsC/1WNwQ7CIBBEf6XZs1sBi1p/xXgoZWvXKBi2Gk3Tf
 xf05HFeZt7MIJSYBA7VDImeLBxDDnpVQT924UzIPmcwymy1NjuUaNFxGG4TWq1w8M76trF702w
 gj+6JBn59hUewtVb1G04/Lg93oX4qttJ0nRC61IV+LEgo+CnGKxa+/n+BZfkA78i26qkAAAA=
X-Change-ID: 20261127-so5-binfmt-510-fdb5d9458243
To: stable@vger.kernel.org
Cc: Zilin Guan <zilin@seu.edu.cn>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795760532; l=2237;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=WGqX07O3Yi7vqeSiFE0eOykUyKkDkZfXWYalnmxLXzM=;
 b=WXem5htlu0I1lz4Nrw5iKOXToGaWW7MuGffZBYGS7Q5dm/kTDOemaNJ+BtprgQxvAdkwRksYn
 wofqhZAox0tD5Atsd+7yEfOYo4xBxt8E4lRIKo9YEL3o2mxbVRv3eGZ
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Zilin Guan <zilin@seu.edu.cn>

commit 90f601b497d76f40fa66795c3ecf625b6aced9fd upstream.

bm_register_write() opens an executable file using open_exec(), which
internally calls do_open_execat() and denies write access on the file to
avoid modification while it is being executed.

However, when an error occurs, bm_register_write() closes the file using
filp_close() directly. This does not restore the write permission, which
may cause subsequent write operations on the same file to fail.

Fix this by calling exe_file_allow_write_access() before filp_close() to
restore the write permission properly.

Fixes: e7850f4d844e ("binfmt_misc: fix possible deadlock in bm_register_write")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Link: https://patch.msgid.link/20251105022923.1813587-1-zilin@seu.edu.cn
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
5.15.y and newer already have this fix.

Tested on v5.10.275:
- x86_64 allmodconfig W=1 build of fs/binfmt_misc.o, base vs patched,
  no new warnings
- under QEMU/KVM: an F-flag registration with a non-executable or
  missing interpreter is rejected and the interpreter can be opened
  for writing afterwards, and a normal F-flag handler registers and
  removes cleanly. I didn't reach the error exit after open_exec().

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

fs/binfmt_misc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
---
 fs/binfmt_misc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index ab14522dcd5b..ce6b5ab4bb84 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -827,8 +827,10 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	inode_unlock(d_inode(root));
 
 	if (err) {
-		if (f)
+		if (f) {
+			exe_file_allow_write_access(f);
 			filp_close(f, NULL);
+		}
 		kfree(e);
 		return err;
 	}

---
base-commit: 99112ea818e35b606397c84fbc05e6fadb6ea162
change-id: 20261127-so5-binfmt-510-fdb5d9458243

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


