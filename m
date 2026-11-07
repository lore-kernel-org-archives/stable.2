Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049848;
	b=TE7p7lZzDlmCAfsmAs0h14T0EaKLMjyEljFWCKOcXdwSaF70du81ZkXAanzmEXgFvA2R
	 1uAPIF4W4BM7sbWQUvNcHlXMGKOVzqA8lBBgKqWLj4vv2S/UENKgXKeRrzsWQdBnj0r/i
	 2ikugHFnF3juKbE0wtgAQmaOxNM4L/O84BaIIxVNbtW2ArgrZhbYa8ihDzPqq0GWRb56z
	 jrg0cN3R4GCRmCbJAxjixX2Jvf9k1Ue3UWbZUNgf3jrtbGlPMFksAYrDvgn9+dAJKHcp7
	 9oVv3S8s7JoLYZEWedwVBZZLdStZ/g/P+14fz2FL+bnOCUqlaVvK++nBwE/aZBN2zAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049848;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1RFdybfjjtX9OxredLn7LtYD8CjVxZNuizXzjIliqjk=;
	b=gind1ujxN5ZpsAOJFY73Ufh1rawZpaEcdqoaup232jIZX3YGuyRjythunLdResylZhHY
	 QM6gYrfAD5NBMxkp6fXdryUPjQ5nhlj4oth3x+cgkANw0/E646KzncNlR9QXO3RDSFa1o
	 6+vyq0skc35sx9wtLaPAfhRXzmUd4tAJeZSbAmcbqPcuz2iOUDd/ZaMiHWZb501uzSRRM
	 i2Bf3K7YzGtrQyB1aumwKZSQBvbXTeJQYN3ERTrpKl/HLErCQHj+NL+jJMujSw1y2YJe6
	 RmmiRwLqII0aUnaKiv6N7qvtzKQBi+lxzSiwK8oNIcS4WLhhj2okyAmZEvfCVO905dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CMQ2T1/E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMQ2T1/E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06201F008A1;
	Sat,  7 Nov 2026 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049848;
	bh=1RFdybfjjtX9OxredLn7LtYD8CjVxZNuizXzjIliqjk=;
	h=From:To:Cc:Subject:Date;
	b=CMQ2T1/EfhuCDyty3O5s0mGTyKGU4PMWKEsZmJIQ1P9cq6JMrNx9rHoiUUkH+gwgW
	 CoF+6FXTlZcr36B6o3RpcUe+EeikoMPsaOYxV95RNYPRL8eaZiK+wRmf5gb1pDmYny
	 5LiCXN7ymX82Oh9IJyXlYok05GVFDNod9kHqq39C7MUOWy9OnU8DLTvTg9EG91s0MN
	 8sV0Q2ddj/2SbjO0S3UDWusKRBVaLBBMo70aVLI+k2Eppe35kv1lB6JJwTMW9xhxLw
	 0wJe1zycB9v5kB/2dUQreftW9xHwEV1+KrLbQT4Tq7o78SSFbjzt/dhfjuxGINlAGt
	 K7clgkZ9SDCvQ==
From: Sasha Levin <sashal@kernel.org>
To: make_ruc2021@163.com,
	andi.shyti@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:46 -0500
Message-ID: <20261107061046-failed-5.15-a65917d0a22f@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a65917d0a22f9b10694853b725f9cd399fc3ef4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061046-failed-5.15-a65917d0a22f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a65917d0a22f9b10694853b725f9cd399fc3ef4d Mon Sep 17 00:00:00 2001
From: Ma Ke <make_ruc2021@163.com>
Date: Mon, 12 Oct 2026 09:34:21 +0800
Subject: [PATCH] i2c: acpi: Fix adapter reference leak in
 i2c_acpi_new_device_by_fwnode()

i2c_acpi_new_device_by_fwnode() obtains an i2c_adapter through
i2c_acpi_find_adapter_by_handle(). That helper uses bus_find_device()
internally, so it returns the adapter with a reference held:

        adapter = i2c_verify_adapter(dev);
        if (!adapter)
                put_device(dev);

        return adapter;

The reference is only put on the failure path inside that helper. The
caller owns it otherwise. i2c_acpi_new_device_by_fwnode() never drops
it, neither on the -EPROBE_DEFER path nor after
i2c_new_client_device(), so every call leaks one reference on the
adapter and the adapter can never be released.

i2c_new_client_device() does not consume that reference. It registers
the new client with the adapter as its parent, and device_add() takes
its own reference on the parent, which device_del() releases when the
client goes away.  The reference obtained by the lookup is a separate
one and has to be dropped here.

i2c_acpi_notify() in the same file already does exactly this. It takes
the adapter from the same helper, registers the client through
i2c_acpi_register_device(), which calls i2c_new_client_device(), and
then puts the reference.

i2c_new_client_device() gives the client its own reference on the
adapter, so ours can be dropped unconditionally.

Found by code review.

Fixes: 605f8fc22442 ("i2c: core: Add new i2c_acpi_new_device helper function")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20261012013421.3597430-1-make_ruc2021@163.com
---
 drivers/i2c/i2c-core-acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 703588e9990a6..84841ed134874 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -549,6 +549,7 @@ struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
 {
 	struct i2c_acpi_lookup lookup;
 	struct i2c_adapter *adapter;
+	struct i2c_client *client;
 	struct acpi_device *adev;
 	LIST_HEAD(resource_list);
 	int ret;
@@ -576,7 +577,10 @@ struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
 	if (!adapter)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return i2c_new_client_device(adapter, info);
+	client = i2c_new_client_device(adapter, info);
+	put_device(&adapter->dev);
+
+	return client;
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_new_device_by_fwnode);
 
-- 
2.53.0




