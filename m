Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050877;
	b=Ece+K/eA+6ns74Gex3zCFmnIbjdJ2qePi0un0mnJdk+EguMJHD5o4uy4I4rhG7Ugu639
	 TBeT1njBxGoBRZ1XIqfqoKizNgiaeN3jGrcbWSNzrIGciZCVS7H5OODw9dhkQ80P/2X1L
	 kKvSL4iW2Y2X7F7xDZ8n1nYgG86alUuDfTrka3y5Esu828TT7Yzgzupy++4cuv36pIMpp
	 RiqPz/r2vdMXXYvPYDNuTiCAWGHbAHZVAF57zG/HNFTAoX9Nz8hI0/00fzchOGgwOmWfq
	 8Fa3oiWUfolQZeC97ABaJJoCBfvVNBE7sFKoJH5jsdY+HC8lhLQnfUmtUEtbdKpjDhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CHdM/OuK6Oo2jIYl1tFOiwYMT3hCTT8WM8/GvALs//o=;
	b=4DQ5bMyl9w5QCrzUjq0v1WkqMkzNYkvGBsCe7U3E3K745VgH9IM9eg5sLY8d6PGRv5tE
	 EKRc9WIVsTS2ZZ6IVl1rmUhWlYKiRu7PS5mcic7i0bMrrvjOWGMVPvb4AeBcF+VDZoVgZ
	 IxK4TJZBunbyOiXYejqyMDweaPOxAllHv95/sPwByV2J7+HEuTEkmV5wispeVD4hcgmTk
	 lsJfADxY9E3xoz9B2EqfRXav6KQcHQz1rhJc/ff4f1Ny4X3sGtKU8UY8s36/V69y6CHui
	 +lKboCsw9B/as8TBbhLhGCog3JSHQ33P06S2t1j+jbALmpc9hKQhb1gCtqOxf3ThpTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kDzIzZ/y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA98606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDzIzZ/y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0942F1F0089F;
	Sat,  7 Nov 2026 11:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050877;
	bh=CHdM/OuK6Oo2jIYl1tFOiwYMT3hCTT8WM8/GvALs//o=;
	h=From:To:Cc:Subject:Date;
	b=kDzIzZ/yPQYJf3rwnGSn7BIKWg4pFinmDasXYBmTUwb74ijmKu3UtGnC1ExUcr7ea
	 s8RBt0D8cjhZX6T8yurC3csFC895PE5gDlThbgHmKbMVlFJtiEzhSBoFzR2qRB/JwF
	 ESL143ECjxotVzquZ3LbwqRXO6uG1+P3vkbMCeL0tKKGOcpqKlozEn4VjiBxNn0/0k
	 rIcug340BoIw5E5Yk8VefhuYdU4ebjPGweC1CbtBWOpag2KzzKYQce+zf+f7RRGYIh
	 Ih5CfHhIvOEFkdF1tN9n63uop2892VAyEHsDrNrIV9YUgXIcg+pl/EVAfmXByDmbPb
	 i66LMapGBfnTA==
From: Sasha Levin <sashal@kernel.org>
To: make_ruc2021@163.com,
	andi.shyti@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:55 -0500
Message-ID: <20261107062755-failed-5.10-a65917d0a22f@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a65917d0a22f9b10694853b725f9cd399fc3ef4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062755-failed-5.10-a65917d0a22f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




