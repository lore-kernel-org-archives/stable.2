Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E908400DFF;
	Mon,  3 Aug 2026 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767533; cv=none; b=WWt+5m3jGZHbqSdVmA0EunRnh4tC4YNNo/pTwiJ/zjnOH5G+pR9P0gBVHXMzzTOSz6RqZjKeowcet/cYSimBFD0pq+3N3m6pdqAywgEA6ukRg56oSL1w0gIvrnHMLsaGM4CaBdXeYJfvTBkfFHtv/bhb6lMbjOtmag7+Gl9uisg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767533; c=relaxed/simple;
	bh=5O33fWoGp4US9EWCyRTZe7h8pAy9wxeHvOqIspbPA5I=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qvr3yI/JOqL9TXPO/lZ9bcGp/kvX+9yiEJyup5zv7MJfA3D3eS2BHhCbL+hJogO+2VBfPeCow4k8qyzjHPMuxjSc/SpwE3Xint+UsHxPRdc23SiTwGY58qxT4pFZej4h33ZZSNWhnjr3Si1w1cJnsjzKmOXOIDJTcTLeLk2+LqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VTZLZGTZ; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VTZLZGTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785767519;
	bh=hcaQLUZaCP7bQ5gVODYDBkvntEwQkNmQV1oN3p8skZs=;
	h=From:To:Cc:Subject:Date;
	b=VTZLZGTZ246Rfh/0gN0Uh0qi/waSUh8pqTxWZl10r/Yw2pr0SrXCD8L4G5Nq+f/jN
	 MEc3og7QHCxnfSfOFz/2PxbdO7Jco10fHn13D0d0KLnQZM6ij3NukPHATppGJDqD1k
	 PZ6gQ34byTLs8eVxBE9z8rri6GBA9ywkkc+U28hU=
Received: from VM-0-7-ubuntu.. ([101.35.250.50])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 7F9140D1; Mon, 03 Aug 2026 22:31:57 +0800
X-QQ-mid: xmsmtpt1785767517tyi7spcoo
Message-ID: <tencent_6C4272FCE4F12C891C300445A9D8E6C68C0A@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+g4LJj121ROuP1CM5YdWzEnk6e6mDo/Hb1nUIk5C4QsDT93aiZX
	 l6k6xlWHvIsbmKj7sz7huCSxtt4WeIHgOaSO8XqZ08IjRnApziWa6thCO+6uWWbKv0VkLIUQgZEe
	 lEnuzNbT03RqGbEHPUTgeHuMx5pChCMUL/ILoEUdbtJL8XdIDQZ5YfbcY1i9WYIAFjLhtT6mVX64
	 yJOF5lSIlaBs/luyl2P9B7Klto8smRgl1NQDDkQwHz70wY2oYK9LtEk4KVSc+Q7gv2KKuhbZnau3
	 btUKb49R//SQ4/fGSM7ds5VoECHfZ2NkDHBHTix1NpQZRWeeh/xfJcD1pkPqDevwH6mJbjJKvQR6
	 vFy1r7PrEVQN2/F/iWBG8beToQpg/3OxZpj/cDk71ex5/n7wj0ntfWqRULibfxrb58kipDLj+onI
	 vvlm4ZhjYQAAJgRjB3IEMbaA5Pb8FGvHzJza1SHsiULGlcfLxz6ks015AntFDexBifTLUM8BhIv1
	 TTcanrOafQoAyKoZFX1lPEo5sKz+hrK7cFiaBdv5V+Qn2o2ULJZSZKlZSM/wTZAmUm0VCxhrD5nx
	 vC+lGQvwR8fWligkxZPsk2ztvSc1vAdlKLdbnMycHWQYQtzcpxa7N9cAuggle4YyDMhwX8dnpVR+
	 EkK2MAuU2kZ6ctbq6hYFn7F8xcblEAcYMNjUcyujll1ZrpsfcPGCqTPctmTHOB7anC8El9wYB2IA
	 f/v8n8OtRKp49wGJdCoUkL7w1Y9ZMiSe2ZMxAlcxNH5eD1+MbUh900zJxig/Um2gKJfDX4WaRm/S
	 IEtuBjzGY7DMy6xP6tPym2BCTZejvnYYmXyYqiFSNRsu7u8oflKM7Tyli1OW2zG+5LHn4mU1/2Mt
	 Hb2Y/F4NzeN4MTcoL+IeuODgWGx7QyEEXmRAV9/GtJ3QMoNjKoIhUJsFte9TnKbuzW6gnRn8icJs
	 35LoHXIPNGNqp5eFgR+jCbHE2M4WJbR8xcAdWtaNPJZvYoqrcIF31jcHGcV0FOpqgzn5qvVorrZ3
	 xNsliKu9ax/wN9U23PxbHnWLPcC0InQS1ababHGII41NPrtD57
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Shen Yongchao <grayhat@foxmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Shen Yongchao <grayhat@foxmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: bpf: serialize device reference release in struct_ops destroy path
Date: Mon,  3 Aug 2026 22:31:57 +0800
X-OQ-MSGID: <20260803143157.2360464-1-grayhat@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__hid_bpf_ops_destroy_device() and hid_bpf_unreg() can race on the
same registration reference, double-putting struct hid_device and
freeing it while hid_destroy_device() still uses it.  Serialize the
remove/NULL decision under hdev->bpf.prog_list_lock so exactly one
path releases each registration reference: unreg re-checks ops->hdev
under the lock and returns without putting when the destroy path
already cleared it; all put_device() calls happen after the lock is
dropped, which is safe because a concurrent unreg then observes
ops->hdev == NULL under the lock.

Background: each successful attach (hid_bpf_ops_reg) acquires one
device reference (hid_get_device()).  Two paths can release it:

- device destruction: hid_destroy_device() -> hid_bpf_destroy_device()
  -> __hid_bpf_ops_destroy_device(), which walks hdev->bpf.prog_list
  under rcu_read_lock() and drops one reference per attached program;
- BPF link release: bpf map delete (no BPF_F_LINK) synchronously calls
  st_ops->unreg() -> hid_bpf_unreg(), which drops the reference for
  its own registration.

The coordination handshake (e->hdev = NULL on the destroy side vs
"if (!hdev) return" on the unreg side) is a TOCTOU check: the two
paths run under different lock domains (rcu_read_lock vs
prog_list_lock), so a concurrent unreg can read ops->hdev as
non-NULL, block on prog_list_lock, and then proceed while the
destroy traversal executes - both paths then drop the same
reference.  The refcount reaches zero legitimately (each decrement
is individually valid), so no refcount_t saturation fires: the
device is simply freed while the transport is still inside
hid_destroy_device(), and subsequent teardown touches freed memory.

The fix serializes the remove/NULL decision under prog_list_lock on
both sides and moves the destroy-side puts outside the lock.  With
the lock held, plain reads/writes of ops->hdev are sufficient; no
READ_ONCE/WRITE_ONCE are added, keeping the patch minimal.

Unlocked-read safety: the unlocked read of ops->hdev at the top of
hid_bpf_unreg() cannot touch a freed device, because the unreg path
itself still holds this registration's reference (released only by
its own hid_put_device() after the lock is dropped), and a destroy
traversal that already cleared ops->hdev makes the lock-internal
re-check return early without any put.  At most one of the two
paths releases each registration reference.

Fixes: ebc0d8093e8c ("HID: bpf: implement HID-BPF through bpf_struct_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
Assisted-by: Hermes:kimi-k3
---
Testing:

- KASAN on v7.1.4 (CONFIG_KASAN=y, CONFIG_HID_BPF=y, CONFIG_UHID=y):
  the unfixed kernel reports slab-use-after-free in hid_disconnect()
  (993 reports across runs); a 3-thread PoC (two uhid devices +
  struct_ops programs attached without BPF_F_LINK + concurrent
  bpf_map_delete_elem() and write(UHID_DESTROY)) triggers on the
  first iteration.
- With this fix: 400/400 iterations, 0 KASAN reports, PoC exit 0.
- Control: a partial fix that only reorders the NULL/put (without
  serializing under the lock) still triggers 993 KASAN reports,
  confirming the full serialization is required.
- kprobe interleaving shows unreg and destroy about 5us apart on
  different CPUs.
- PoC source (164 lines) available on request.

Alternative considered: an atomic-exchange (xchg) ownership variant
was drafted but not tested; the lock-based serialization above is
preferred (uses the subsystem's existing prog_list_lock) and is the
only one with dynamic verification.

 drivers/hid/bpf/hid_bpf_struct_ops.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 702c22fae13..049df064776 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -250,6 +250,11 @@ static void hid_bpf_unreg(void *kdata, struct bpf_link *link)
 
 	mutex_lock(&hdev->bpf.prog_list_lock);
 
+	if (!ops->hdev) {
+		mutex_unlock(&hdev->bpf.prog_list_lock);
+		return;
+	}
+
 	list_del_rcu(&ops->list);
 	synchronize_srcu(&hdev->bpf.srcu);
 	ops->hdev = NULL;
@@ -310,13 +315,17 @@ static struct bpf_struct_ops bpf_hid_bpf_ops = {
 void __hid_bpf_ops_destroy_device(struct hid_device *hdev)
 {
 	struct hid_bpf_ops *e;
+	int count = 0;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {
-		hid_put_device(hdev);
+	mutex_lock(&hdev->bpf.prog_list_lock);
+	list_for_each_entry(e, &hdev->bpf.prog_list, list) {
 		e->hdev = NULL;
+		count++;
 	}
-	rcu_read_unlock();
+	mutex_unlock(&hdev->bpf.prog_list_lock);
+
+	while (count--)
+		hid_put_device(hdev);
 }
 
 static int __init hid_bpf_struct_ops_init(void)
-- 

