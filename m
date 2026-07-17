Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C73EC6AA
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285186; cv=none; b=ZeFKrHQh/3KExWuG6XYkicp9xOZfBaUQX3BtJhZJ4scwJF9UtLFjdusU2o47gnId1ALRyp8xaUguBZ/IpV009QB93+xLJ2keYyjhn6befdu9TN8T0dQ+PWD8lUsiGs+lO0izyLN+jRjDVWOWpiWcWemL1cmd9fUE942ArjgWZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285186; c=relaxed/simple;
	bh=Bu6ynCKZ0R7PBlqzGr8CS3vWxTyNWE9aRnYVfnWA7FM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tp9Rr/2d84rkFjXF5WSiXtj0MN5AMnpfe3JQw4FCroEc49FVejXUtkk0BzhUuiw1PhWGivtD3zysR4yYdifQz48WIuhOAUhCF3UeosFnRELn1AI2mFtJXoayXvDnTc418uGSD0YR7PF1r7gWzCsU4+dpkzPMa0SYZbcOIWC7Zp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AVJmc9Sx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AVJmc9Sx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c160420289bso1069126666b.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784285181; x=1784889981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNBp1FY7COTWRBaq8toEDefmotAUnsDCii/Qf5TL19I=;
        b=AVJmc9SxYlnKh/kv/wAcBkUlmyEunJ7mJPC6QR5EEC48KBAFFY6joZxqc17kSYj3Kb
         h8EfmjAMkPGHMqeGwB3w4D+Xy5Jmrx01JdYCk4Q/1+zAMgwn7PJCwi52YvjZi6Uirw5A
         Vmv9jhMinGf0QQDU+PQfO1cvVxFjsy/vBNwF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784285181; x=1784889981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNBp1FY7COTWRBaq8toEDefmotAUnsDCii/Qf5TL19I=;
        b=ARwwu7EVAbuKKIjWSK/3GRffmn5oxqf0o6aFKY8jbDrbZFxmG4eTUpAurfsMv7XVHt
         BbBe+MfxjT5V6AUxZpOPBUaj7oY3XkDhQoCnACtOgUFbXoDIrUtbROx1pMo+4XfZ+arO
         CRMPvb5aucXJdEJxEftDpnXpw//dg4QwgAtw9B7YuqilYDLoDPNgMR8gCblnxg2XdOK7
         LUxvMQiJOYlrthtS5UD0iqzj0GByCA3u79wqprrdi1EdLMBUEOChU5jAzY44Jityxin0
         MrMwEjKKWNdBFmtHYt8YLDt0Zo5aB7mXanUTNYBGFgO2SDux6y3yCymUHeoQyzQblgeO
         RudQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCK01eDiMRUIUPYeI4ONjkmxujT+cWYH+bWpehlrAQ8xTiTggmquBdRsSv1FwlD1j3xXSMN4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wCE+mIlmVxnNGj7ClRXOlMWyLbWu7+1lWudwcA+IOb23ap/0
	Sn/dshrOGJeeOIyWcSS7t3usSiehsmXZb41h+w2Y/IhkCjo231ACRXIB5kUFMVSk7Q==
X-Gm-Gg: AfdE7cmgBEsqOXVp/m7YxNezRvwOMzjgoBPz3BmgIhEHEEctfRJIHuSY4FisK1ABlW2
	SvvbHfuiDXiEnrDKM7xL7/SsQFzhqPrurDHJpdaInUV0yBBPlLr9PkKruCwjMdkOOH4W5ggsRwS
	UEU7DOvwmM1KXjHReRL2Jvesn4zS3NUAeX+KI2oKNE5LkIWnthBnbYG8G7KPYlvWIMKGPfg6zpa
	i5e7BmR0dVnApvUl1+0Ocuqu4OhQr40w7lAFP5JiTspY1FuRrwKw66QdMrtt4AykGNmBUfkz773
	+V4QH3Sz8EGkdFi3EHkQl6HkocyE4e9MYRm3yIIuvLg4oUyFq1o6eoYuuRh+92SUlf8DCPqFSg3
	W9pAIJ8U4vWFT29CqAAUQLnYwA2Cstc7eGYBc7BWw+13Ho63coXgEdSMRPf6UJRw9/ZzT/Qtebd
	ju1/6W7GKB3ylljzdWy58mOd3sW3KtprRuSFTB3qpVJ1MO5LWp7L+8W6COMctB4vxCdw==
X-Received: by 2002:a17:906:9fca:b0:c15:ce72:9350 with SMTP id a640c23a62f3a-c16b47d8363mr98457266b.41.1784285181113;
        Fri, 17 Jul 2026 03:46:21 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (91.27.34.34.bc.googleusercontent.com. [34.34.27.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1724f50bddsm56652966b.47.2026.07.17.03.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 03:46:20 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Jack Pham <quic_jackp@quicinc.com>,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: Correct teardown ordering in ucsi_init() error path
Date: Fri, 17 Jul 2026 10:46:14 +0000
Message-ID: <20260717104614.325250-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and
ordering in port unregistration") consolidated port teardown into the
ucsi_unregister_port() helper. However, it introduced an ordering problem
in the ucsi_init() error path.

Fix this by ensuring ucsi_unregister_port() is called before we unregister
their corresponding lockdep keys.

Cc: stable@vger.kernel.org
Fixes: 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and ordering in port unregistration")
Reported-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Closes: https://lore.kernel.org/all/22064276-6c56-411a-9f20-6917ceeb865f@intel.com/
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
Changes in v2:
- Added Reported-by tag.

 drivers/usb/typec/ucsi/ucsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 1ae4224d2dfc3..49f1c53721bbd 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -2142,11 +2142,11 @@ static int ucsi_init(struct ucsi *ucsi)
 	return 0;
 
 err_unregister:
+	for (con = connector; con->port; con++)
+		ucsi_unregister_port(con);
 	for (i = 0; i < ucsi->cap.num_connectors; i++)
 		lockdep_unregister_key(&connector[i].lock_key);
 
-	for (con = connector; con->port; con++)
-		ucsi_unregister_port(con);
 	kfree(connector);
 err_reset:
 	memset(&ucsi->cap, 0, sizeof(ucsi->cap));
-- 
2.55.0.229.g6434b31f56-goog

