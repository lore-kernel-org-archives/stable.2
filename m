Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915D527589;
	Thu, 15 Oct 2026 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066908; cv=none; b=uUDmex0V7u77zRmnJbY3isC87tfWHNp5VvuZQDQLzJ7kxjKomHcpc+6m7Y9xQ2jh5bjP+u+s+uDfgLhfyG5utJopu18Y2ZmHuUuIq3Ff6zmvEOuI1K2gZh81ShryQDJES7+fRQ8ATe+GQnvx5dtCM1Sw/12jZqOw4xeJdAHpJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066908; c=relaxed/simple;
	bh=OKZzV+jzLkLL4eGvdOYRnV/ZDMA8dqhIPe6G3zjVDcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlLsnZLtCS3OuCqGTncwUdI2KcwCAtuKbGNviTngOPSyzM04vdGfvNuhxHQzVyEiupGYn930cVKhBnx/LnANKHFmlA3xdreJqM2fW3v8ZNVPOps8eIKzmQzycI2rYBAfcZwXixmVndmgqKn2fvR3wULLweFvAGPVMlJpodTqd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1BfT0rZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1BfT0rZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548971F000C4;
	Thu, 15 Oct 2026 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792066906;
	bh=WD29J9Xu5UycCnNI+rkzN61pTO3o6PQE+hLcKn3mnlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1BfT0rZZJwaUi/IpiUfeJSUt4uI6CLAhvx0sl0DEAOOoHQYhw7DOVR78+EZOqU+bC
	 pF4qEazl3BzYYf2XbiDFUtpcxgsZ9rRg9VgIR6CvIENaDZ/EdquyyX/xLjqXdJ71A8
	 pYs0+96IEaCW/NostrvdddtYPV9uxr8c6H1W9Xmg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.272
Date: Thu, 15 Oct 2026 14:21:44 +0200
Message-ID: <2026101543-fiftieth-apprehend-5ad4@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101543-chariot-disinfect-8cd6@gregkh>
References: <2026101543-chariot-disinfect-8cd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

587461ddf5d522bfcb50ebd55078c0dac37be496
diff --git a/Makefile b/Makefile
index ec9b4e32fdb9..be27886239d5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 270
+SUBLEVEL = 271
 EXTRAVERSION =
 NAME = Dare mighty things
 
