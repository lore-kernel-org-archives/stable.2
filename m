Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79573CAE66
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514892; cv=none; b=W1ipyP7xWatDUmwTbv2w1hvX16RDQl+hBgg+y5XxNwK6K4dooxHFfukFtKm1dmlVEblYMqcxWFM0VKp03BUvK0T1kXDCflkgaHBowMzn0zEKn/e08uC/DUZcTrHqi1vjQqh9vEHKwSub8mml6br5CmTHRAxtFYLjO0HM1T5Jov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514892; c=relaxed/simple;
	bh=65nzK6vz1vgFR5pp0Wddsk4Ce3ZupOxMWzv5vPM7shw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1P029hYrNqQAcRRVT/HjOQauwGN1Zhew1ArjJShR5M5QNzFUDY4rHN3LTBhEDmUjig780ghGhOnH8MJkMtIIZAdUKKyBaui8tk+99UwigMmpYwPuDDzFtS8zawt6ODmo3IcznDc5lWfmz+AVhRZy/lbbkfZQu4scS/macemXIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48351e5bb47so215635f8f.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514889; x=1789119689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ABcFiasFOwjIfnBE1VjTMy+55UW2Q6GZ49iMrPVroV8=;
        b=XoJF8I48sUawIAe0qmpwWbqWX9IPr7QO36fLzOFvhFAHVwApRE88gwCLIALFmefVpt
         3fQFPRz/9FwTUJuHeKuT0unjX/fyc3LqH95hXSxAGHug/1/HMTa0POrX4eOStduifrDR
         CayqKwethKriucfAmj+fI6eUP6qCkjMsze0nkeKeM64w6igvFp1fLqYKjaog2iRESw/Q
         dWHpEiGi+LY5u4l8ttqi+jAajWK3UH4k2NmmuucxXpF1X3Yzt/G86YqTT5XwsIqzGM1D
         sRqw8yNByxpniHQekoJX7GAEvi6+jD3n16T/bo/v8vmQI8vCt3L2Gg4iMz2EUy7YYz/G
         LISQ==
X-Gm-Message-State: AFuF++kZXvkvPSC4W9Q3Rw/UiESOcGpG5Q7bP7si8GvCYK3xFvZd021p
	m1C5m9xJx42depavthUAlZ9m1J+PH1K2UVj2qFl1NEPQ93CDDV5R+XRCRVRmSb/e
X-Gm-Gg: AYBFou34G0XfubZWjMigcCIGmGBpV2jtoDsuNeJXxX5CeYlrS7O87f0x1sX4ovXGdLO
	IhBlRQtbjJJawh8yevMxmoO4PFwJgC9B/pPoJN9RYpH7aJYORrdOqSWP6UoGqujM3+r5u/WsA4x
	8Z5Bp9SoPY7QFYe7aMlLcqYjwH3l8zYsfFTMFh8kcv8rzK95lrYUNeH5lST1TXtD4m6vNPAw6cC
	j4dmnS+RtOA5MSnJMx086XADgfDJ1XLIQZzFXSlt/sqQHF7FKarILS0Ko7Nw0nWQL3v2OhKkzzu
	WFTcVitDWIQLN9hw7JC0AfWRCBDNlu1fhfmXcb0T4xpNcrWbXnOF+hT7FE1LAhgcgHk2Cgxs6uR
	Mlo1sO33YickGZXhcY7WX+/zieKL9Y7jSIZQGBRfoQloOc9zOnjqVygSstzv7jjqq627jQY4Zi9
	kiKUnoImbyf3gUsFgPxlIYTqNfLHdU+6kHBlGbKCduy8qAdadpi6qetHfHqUaFBbqc2voCwAXTY
	vWg/7sujuExqd9uVdM=
X-Received: by 2002:a05:6000:612:b0:485:8e19:1979 with SMTP id ffacd0b85a97d-4858e191d46mr397655f8f.11.1788514888553;
        Fri, 04 Sep 2026 02:41:28 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b1320sm5178576f8f.27.2026.09.04.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:41:28 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH 6.1.y 0/2] Backport 'openvswitch: Fix CT limit teardown use-after-free'
Date: Fri,  4 Sep 2026 11:41:01 +0200
Message-ID: <20260904094111.1816002-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090350-galvanize-epidermal-77ae@gregkh>
References: <2026090350-galvanize-epidermal-77ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch doesn't apply well without the previous kernel-doc fix.
It seems cleaner to backport both instead of modifying the main patch.

Ilya Maximets (1):
  net: openvswitch: fix kernel-doc warnings in internal headers

Yuqi Xu (1):
  openvswitch: Fix CT limit teardown use-after-free

 net/openvswitch/conntrack.c | 122 +++++++++++++++++++++++-------------
 net/openvswitch/conntrack.h |   6 +-
 net/openvswitch/datapath.c  |  10 ++-
 net/openvswitch/datapath.h  |  26 +++++---
 net/openvswitch/vport.h     |   8 +++
 5 files changed, 119 insertions(+), 53 deletions(-)

-- 
2.55.0

