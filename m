Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6C3B6BFD
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514727; cv=none; b=paBUs4msXL7M6bU4haEs6p9a9GqFZMsAHyK5UNhCQ1Zjc0OaSuaG0zU9s3CVNWUzUumi3rRfruUPG7Zm8zJZ5M5qKH0JRtqdt2mn8UFNinywyU78YBB4gJ8CAy3PVogO2Ze5OrbHgsguv0Y+14YRvN1K2/i3V/IwT0S0UuIPzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514727; c=relaxed/simple;
	bh=c92KD8HkyT2vgrScZ+g4UHSA6I8oYiVXDEKf2c5Dync=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js9BD1Ia4B3cX5vlhmqjV5XbRB0LJQj8zWqorxkz7nTklS+rhpKiv59UKbP1zwlU1RiEqEcFzHwGhahia5MGKLDMJv7wSG7EcUe8L9dwC52r7UXHy8E7gTSZG0gtn/pnUrPNo+5n0ZZ8CnGLwghkTn7QJ914zO6HoQm+uQAM5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so1638875e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514723; x=1789119523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J9uF+DTHVtS2qLKfknjdApk2e4kyV9U8eXbfPCF8xz0=;
        b=ZTtrCiWQCwYOG/1MZrjVcTpyDI7Hu6Z5oyOl6W1DphE6rYfXvW283bq/ycsAWzDIWc
         +tUJMnRMES3XtXFGeqIYPvprozdcoqg+QW1g9W20Ype7lk/UQs9NkmsETcGSSgzhZBE5
         3QRktGtS4VUEszjPICSnyt/evEaeC7Q/D6AJxXHBmE0hmMzJF62AtscZFD3eJiNM+iHW
         ZptDmFobLokFoXCCcJavdR5C7FLB5gIdGG6naO7BOFUYkyAwWl9SQc5Ri+y1ZrWrcn5o
         XyIUbZFnEW5CVlYxgHUafgqb2Bk+iENTLwVNAKEPUohQY9itbd85rd20TORXFWRrcjcF
         U5hg==
X-Gm-Message-State: AFuF++kRZfKtKs9JbHJP53Lrxx2YaolHe9aR8FpbZXrQA76Xo6ubmHT2
	npAKglxz6FMbOSVlczkYnbvQM1sia7CzM81s/6PRS6BgftwM8O0TtBCNQorqdSTD
X-Gm-Gg: AYBFou1tnJlGNY0ofk9WRoSqj3zT82c+c/QKF66J0mHFzxojg5GVqaWWwY3x1vPTi76
	C7/WEKen+gAvJeFsaBcwPkcUdQXiTzHYWtYPshIAn5XrLE7P6YOrfCJU1ahyaZgVFGrXk0hlVEt
	N+uecAw8KdJBbsmnvkgnXHkycj9Ymmn+MUTZfN5Sq2XFMnJ8leDOx9tXlg8jekXLilahSnuNKt6
	fTXXBkZYcESCzdMY+rExgS+kncM+RSGC0UXkym3P0xnu3CnVIO1OtbNEH4dvEMTD9uByCc0KOY1
	uw+zFgNJN1ECCjWYRcv2NhLm9pbV7WiKTQVsxqJ8hgeL76ceeQ0X/KEZlg+SgpYTrNMiagVO23a
	8jtk7bLbTu9dmO8EW33k6djcNZWIu40YSWlH0JrhWTTpe9yGtE9GToiZgkCsppzQHJElm53lYhS
	2BZPsQbFHD8Q9otJdz/6V9Jjtz+8vou23n/yAMse+aUB0oj0nEqO1aluRB2GTeWDAX4xAa5pCxm
	q5x+zaSxxv7YSK5dyk=
X-Received: by 2002:a05:600d:8487:20b0:49c:cee0:e7c0 with SMTP id 5b1f17b1804b1-49cf8261bf0mr55466965e9.16.1788514723170;
        Fri, 04 Sep 2026 02:38:43 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740af2sm56458955e9.14.2026.09.04.02.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:38:42 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH 6.6.y 0/2] Backport 'openvswitch: Fix CT limit teardown use-after-free'
Date: Fri,  4 Sep 2026 11:38:19 +0200
Message-ID: <20260904093840.1815273-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090350-daily-ultimatum-52f4@gregkh>
References: <2026090350-daily-ultimatum-52f4@gregkh>
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
 net/openvswitch/vport.h     |   9 +++
 5 files changed, 120 insertions(+), 53 deletions(-)

-- 
2.55.0

