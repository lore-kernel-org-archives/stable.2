Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175636B93F;
	Fri, 21 Aug 2026 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327174; cv=none; b=rybZXGdLdPOjRXt66kgdBuUG1XzaDSNZtIaEb8oLCkhQ8zB1PRyhqrnMqXZAKkch6SKwaqpe9/1KTwCoceK9aQP4poh/S7iGgEyyJEanhEpfx9xAnLMJjNxyhmYmU4jJZaA7iy/XLzzDdqX04c5Jk/i828mQHMvW5qb38TCaMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327174; c=relaxed/simple;
	bh=+NJ107z9nV8AUntTsS7PBzMd4F/86z6wjZkxwerGXM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmPtPBeY4t3xC0NSR/ZSazGFMZ/c+Kc5PLxUTWEXSHgXn21UUuO4MXNo9Dc/Ls5Zz7fb/EI22QAm7e3jurrgOHUnWKKQBDXqc6RbMnJqVBVjI1Bid76/DG5a0BYvveOtQvQ2pqm3ynJAy4c76jUop4QocHVUNKeMmwOo3L4hRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1ERU8BK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1ERU8BK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CC71F00A3E;
	Fri, 21 Aug 2026 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787327172;
	bh=DGOkQmPQpj6V+JAHI7HhrOS8gWwmFW+2R33noOQu0ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l1ERU8BK5N+O8pxyNTATSs4oMhS8fy8O/T74xanCJZgch33cb5xwe4nz6nneZvQvQ
	 PYoDTrFQ0rG9Kxfb9gIhgW7AfWnTRp/nGbW60VYozX/Ulw3l4R8edibsXmgXjwxmj/
	 S62OT9sNKHyb8aZlbeldnGDJ6AABVv8h+CyW1qD2d13N/zFpieewELJ4Ie42u+2e9r
	 ckSr5DUGMPHO72yKgqS+W2qhvBL3MomRFQdcPnOSIeokL8u2hJJHr8JvsXwe4OEvvv
	 poahqkvQoAX+eApChJl/a3veJpxTiw1FXnERVB+x9136ySBAPkX9D0vPZtAOn8KWwI
	 ikurL6JCtQnXA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wxRRa-00000000UvY-26Qg;
	Fri, 21 Aug 2026 17:46:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] USB: serial: fix dynamic id driver deregistration race
Date: Fri, 21 Aug 2026 17:45:44 +0200
Message-ID: <20260821154546.118809-3-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260821154546.118809-1-johan@kernel.org>
References: <20260821154546.118809-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only free the dynamic ids after having deregistered the driver and
removed the "new_id" attribute to avoid leaking any id added by a racing
write to the attribute.

Fixes: 93bacefc4cc0 ("USB serial: add dynamic id support to usb-serial core")
Cc: stable@vger.kernel.org	# 2.6.21
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 9e2a18c0b218..295c61afa44c 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -165,7 +165,7 @@ int usb_serial_bus_register(struct usb_serial_driver *driver)
 
 void usb_serial_bus_deregister(struct usb_serial_driver *driver)
 {
-	free_dynids(driver);
 	driver_unregister(&driver->driver);
+	free_dynids(driver);
 }
 
-- 
2.54.0

