Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674973;
	b=eHG1lJ4jQ5QTFX1gZDJM4XoiFemEimSSw38YtqAuOFE/62k7YIpcJpGfIlosOVn5T4GO
	 uwqJ8MrU41OD+J/Y7ZkWo6iwAt6xIczwcnYpYUM7hSpyRsIQYxUoBtifWPJhoZkbEGajP
	 oB2eiPVkfxZnmxslO+cHE7FRRUpXlfmxtMhO9r3c2ciH7fmBHopdVowl1gCFEZJXaJ66S
	 MP1JhV31bd8PiVAK94aS6+pM7g5J2Ff/jNAfjbxnf0UqphMHHlYLfOTH0dBgwkVb7JeZq
	 UBMMu3OITBUcttnt7I8eZa/HX95mj5lqeq2n2isGeIWCR4wJ0Wx3qwJQhOFUQxMlgug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674973;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LDDJ93BkO849C2mhgv5WGiNanef8BM3ODaG/2JsNB5A=;
	b=K5GLy6Az3DPHTay6W1f5UUkKvKtZ+s/z51uuUdVkLu1MtHtuJw+Dm8tI3bqGCcmhcu0O
	 gjFruTttxSZDQNWMGTr4hlEvoDjc9TWRPIoPUhafSjfwx8Duaj0faQ5PqONHRB5YIQtuN
	 zpFnBKiTQTz6BNJIi4NWmw4BGLFpdQdZG9Uq77+Wl3/kYhWYPb+zPoE2Z+CTlFRgfN1qX
	 k19FYUxmY1tst6roooJUzO+F3kY6bAv3XI1/C0tGkfpQyGIFo+1o3Chjo/6aKdH3cV/Q1
	 vqPeA5eNNUfKd15FiMo9JPhAY7QoVOkMuZm0XeedHmJJFjohbpSYapZIrVEvF/K3hZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQJWkRdI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 34E45606A332;
	Tue,  3 Nov 2026 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQJWkRdI
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4FC131F000C1;
	Tue,  3 Nov 2026 03:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674972;
	bh=LDDJ93BkO849C2mhgv5WGiNanef8BM3ODaG/2JsNB5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SQJWkRdIcjvAY4W8I1hKBDHFP+BiR81cLIPg9YWzvy4whukwNKfwQlFC/F+dnuBPm
	 JDC3INvVchW4+cTJRN2+h7MS7EQO36Gv+hlobgituZzhXz+FsnYY8xS37YUUrIhM5w
	 khhgdvxq2y9w7txWIVba/jbkE0Su7U/SGtn0M5Y5ymyBOcyBog1gw2rhvWFVIMTSqN
	 +gumTBvv7MMoXjxOYdkrOLm0R6FDzGqIhd6KeZJvGhT/BzHDlQSc/G8cLc4WZka+VQ
	 9V4MYyw/+t+Kz7ggGeNV32VYv2WhKwJJI+027cdjCdGvO9UDJKJhLttuTPZMYF6QDi
	 fY3Tfkd+cinwg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()
Date: Tue,  3 Nov 2026 05:02:07 +0200
Message-ID: <20261103030226.2685251-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103030226.2685251-1-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
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

Call key_put() before returning -EKEYREVOKED, as the reference count gets
incremented by key_lookup().

Cc: stable@vger.kernel.org # v6.12+
Fixes: 5bc46b49c828 ("nvme-tcp: check for invalidated or revoked key")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/nvme/common/keyring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 32d16c53133b..87cb51e1f5a7 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -35,6 +35,7 @@ struct key *nvme_tls_key_lookup(key_serial_t key_id)
 	}
 	if (nvme_tls_psk_revoked(key)) {
 		pr_err("key id %08x revoked\n", key_id);
+		key_put(key);
 		return ERR_PTR(-EKEYREVOKED);
 	}
 	return key;
-- 
2.47.3

