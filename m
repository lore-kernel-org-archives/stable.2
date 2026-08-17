Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A10449B16
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982626; cv=none; b=pCyH1MeJCC4lY27zJJrp+G6YBk0YumqpnR9JLqnEVjPa14XU+8WzYbljHC9pgsfZf5b8/jE3MsxDS+FYd17ZHYGoQoXv0a30yS71x58xMz2+vl/lmiI76O8UHF0jTK9zR7wK+FlOlRzJWVbEqJ6ZTcvWNI7M2AKZipGLPhhE9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982626; c=relaxed/simple;
	bh=yguGrGipj1Sr3lM9LirwlqlAubM2+wrNpMoDM1U6p5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJx5mIY7D5ejo/4s5KCB9DHsqWNgnon7CojGOIHkLOHrH+W2z3HKabbZ68eXhzjj0OeQjN7LGnCU0wA8V02e3pTwbg/JmzF8iiF27UTiuzspYCoMr9A2xjyMQ/C5s/65y5fcEut8hUKknBiHSHOeeThg+lwY+1ilUNYKm+h3Mzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRVXyAfh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRVXyAfh"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacb8416a1so34674125ad.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786982616; x=1787587416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7eAUOGoRQ+1j0VLJyMKulBFqB6sfqwvkZHzDAzcL4Sc=;
        b=oRVXyAfhw1YQ1MN0B0HFJVplEVhCpIMepbJ9TURT97sFPPU0nd065c/WbFCTkzTzeR
         LlUzq0+pY4aFExfYmYJe9I+GimIKv5GSb8ob+PvynKYPk0tubP5eq76AOTP18jqHb0m1
         WardKUGGlq+F8oEDUcSkgjGDsnvZo7XNw+D2+sT8xGAH7KXRRUk89jGBak2h9tOXr9cy
         OYqKKrwKRgBhOxMhBq2WGmYAueznuv58uIEJJukyd7VmSrwHhxaQ55J9ZH18Fl7taEU3
         Vai0YpMPvWaG8PgOMnme36JssS21ul9vIP8RXadPT4X14QGXEpnc+mRO5D94Sn0gp5ov
         L0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982616; x=1787587416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7eAUOGoRQ+1j0VLJyMKulBFqB6sfqwvkZHzDAzcL4Sc=;
        b=KZ/nuzb5YHkaugtrZRKCKOBAWuHz03KntaHRxkt1JrKFZ/d0G2R5aQK1mPgNciqbuB
         eyecYIN2+l+CpDuEW3pE61I5gKP69Orpm3CTU/qAo4vF+HYq7ncc0gWRmwltS5sMXsj/
         W9BObMqcBRYZr8LVapcXL7Mlepd+LUSghGzE+/BgMDeV4gbTumKtlRg/l6W3ESen3s8e
         2nRhQfpzPw3hpsNzDNRaXsmzUzXaIpLqDh528Hdi5DtfHuosPK4WiIa9Bk2ZhSD8Hmzn
         OD3F0TX10ruc6HEQ5fmK9LyA6iTWQG2jUbn+aF9oa6QTiwmdkIw07wl+xRWmbZWnPYX3
         xfwg==
X-Forwarded-Encrypted: i=1; AHgh+RqdRlmXpxlvCyPjgwPmJSJ6j4W1hX+N1v01aHLqHrWkn53KmhStBEPIaWzgoIbIOZ8qXeJ5NtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKqJM+uiTLyZPIQCgCFRzjugNwyitpoRzeXpQy9DZBBYaXVK0
	jcJk9lMjgxUM2IU+K4wW6Ea7vt+7e9Sjz7lBnVT4gJK99e2nUDDrYP2a
X-Gm-Gg: AR+sD112npHzbXAT/+g4sjzqR+n4o6D43OJlBZQC1w48OOLwo5ST84atZ/UmhtHrAH8
	5O26oshLabTSjwfnaEoCuT0j7Uu7BAdl30t4+MVDTDCVOBNbiY0EiwjCoCqlhr3rKTiQKp4Y96n
	LdLCfifsZYnmhQJykg6LxzjrNCxG1Y4jQjzQOGpBiycvSP2Q9itjEkvjFrcoZCaNsGSIFfcHyjB
	vYj83zekWWSmq2hbDJfsM6pnZSYXE6uqkgwWYUjYuhXeIHpJCpgpxpZzLskpCdqeiT9hKTnfUu4
	I6SG70JShIPyPfCzj/P5UtJjpINJRrgj5CoFI5TNVATLL3eOecbnlq7hJ/C9kGA7JMRjSs78vot
	yHuw5YQ2v0F0sWh0nWlollVJj3jcIvJvwCwisKwdbj+zgFHg5Wl9hJGtWDz+vYxKn936O5eICIc
	TlRT+IgbmfgOCN8iRLpyQvwV6D8sR04noBRAXuiM9ua1ojwWKH2mhMqyOXwYo4q7S/GVt43JjlV
	n7l
X-Received: by 2002:a17:90b:528a:b0:38e:5ac1:9517 with SMTP id 98e67ed59e1d1-3933b7c3696mr26862150a91.3.1786982616335;
        Mon, 17 Aug 2026 09:03:36 -0700 (PDT)
Received: from Default ([2409:40f4:103f:ca54:3a70:ebd6:25c9:29fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e31a9dsm5481969a91.4.2026.08.17.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:03:35 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: stern@rowland.harvard.edu
Cc: christophe.jaillet@wanadoo.fr,
	felipe.balbi@linux.intel.com,
	gregkh@linuxfoundation.org,
	jeffinphilip14@gmail.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com
Subject: [PATCH] usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
Date: Mon, 17 Aug 2026 21:33:19 +0530
Message-ID: <20260817160319.28251-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e52c5913-9210-47cd-9a97-ab00547f53c4@rowland.harvard.edu>
References: <e52c5913-9210-47cd-9a97-ab00547f53c4@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026 10:01:36 -0400, Alan Stern wrote:
>In fe5a6c48fd95 ("usb: gadget: storage: get rid of 
>fsg_num_buffers_validate()"), the code that was changed originally 
>required the number to lie between 2 and 32.  Even 1 was not acceptable.

Kconfig currently sets the limit from 2 to 256 with default as 2. However,
we use that only at build time. So, if we enter during runtime via configfs,
we set page content to 0\0 and get the null pointer dereference. So we will
need to add the check for num < 2 in fsg_opts_num_buffers_store() and return
EINVAL? Upper bound is 256 which is below what kstrtou8() can return anyway.

Thanks,
Jeffin.
