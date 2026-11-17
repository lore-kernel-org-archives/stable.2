Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953701;
	b=YlGHs2tETcg+aErMrN3wbjix0kyXv5uKE7WPYivadzJXrw4Nf3eQmYr7QhdLDzqT0R3H
	 5LadDLjpCJjL5vVK/ftT6mKzQj5AsareuDZAurtb9oKdfayCuWuQtpMVV/ZY9mR0GPi5c
	 AfUN3OQ75hv4C0i0BNi1tCSNnEuJFUGbily4axrEVXRYoh4MUNN2cWxrvlI/UQBC9IoWD
	 IIj80YaqeUVCzFsynNwJt2RbKm5t1661jkKbsay5MdnUVk8uyy1OzPyOJrgx5/hwoEtHT
	 C+vWs5Ttp3GHcjHL2BjctfG8CJJ14dxUi6mqtVdwUf5ppHnUHZ55C7OzN1o4JEML+Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=AAv7hl5MrgB1vpOHPo0LiyBaHE4YcZ7pafpcrpMVxdk=;
	b=iEq81uro7hhbWsHmx1CDPWE7uqb0pSqufkbDBN60TjdNOnfeqre1YP0iZLotR5LV0zV+
	 i9qZBIoYcPnte+zpZGpSdxq2fCnlkjcRyU/JOWdexHrCF41tUoQeFDVmkq8xVv9hEPA16
	 NzoOOW1qZjGfOHHzwak9T612RbQkjh75sxWq451MGaarrXEeYippiw6abwkwW76VKAAuh
	 uuMCtfYjW6t5sfNcDqMKK6XvJtgjrCxaEYg8zISYnSSlp0d802+SXPzFkRb1IvTawW2S+
	 Tr5PVwN7pFA0hpdBvRnjpmFPGVqFUU40um67SiIOV0jiSHJ8LG47GxXytbeSiIOsrnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ptOjFYU6;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020A606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5020A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ptOjFYU6
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b1afdf5196so134192eaf.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794953700; x=1795558500; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AAv7hl5MrgB1vpOHPo0LiyBaHE4YcZ7pafpcrpMVxdk=;
        b=ptOjFYU6l9FDcqT0zN8EWl/bUXX6gCNlEGOUzVDF7Fg6lk0a6kY3Eq4Ix6obStoBaz
         ZoZ8SOJ66lrCzYI3zgDnpa7gBY8cpoSfp8K8qoL9JamFnCrv8qQmEpOf6AsuAv/kx03g
         1a9YigG9SFPSTIfmTsxn7xReA1G4Bg/NmGmms3LYwXqZlo/y6QKQavr/HIf3gCn8D4Nx
         a/zFFxW6uksKuXS8pbOwhpAvXnvLwmWSq7g/VPBR2MOns9JlZ2IVKCpWsW7SyiXibRU6
         CM4HOky+YXR3yjYohk47p/+lqnXkrjU6b1OrsUzeCFA24VuoIC06+EIUYSmvw02vD9qY
         +6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794953700; x=1795558500;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AAv7hl5MrgB1vpOHPo0LiyBaHE4YcZ7pafpcrpMVxdk=;
        b=aHEmAZn1N3FddvAMEWnbuRDcoRNingyLVS0lQ4TAagsW1JL4O38GTzgH4JA7+vb7qZ
         b9UmxajfKGhQLZdokwaGN4qw3iztTsFmSD88AEQkLfAmTQ7yxE2kxyRh/ZJomrqSebiq
         I222wbMCrj9HU4zEvAVrZZhYXj0v8YwlWiUnORB1FaKSVDozMZN82KT4J4OmfhXvKSVS
         MwRSkzZU8UnOXGtbe2zpOiuq+smQ1zR9x4mxz0NYlIwoUiypdHVXrE7FGq9WUGzdfpIF
         uotvim3XhHa2WSxvkkWe6SL/OiFIriuz1FFKmA0bLhSnD/OK25oHcqJxCxHNtlgmGtai
         1nDQ==
X-Forwarded-Encrypted: i=1; AL+hErFaG6j9kpVwwix6fSRbvTa3dmwBLWRhlkMcStWaU+aiPfGWfLf78TTe0sH2jMRrADL2N9gxERc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dMrqYXzsk8hHPOK4NknbMvVc+hQ0Slvm4vCv7JE+cz+ofUQD1
	FdMXvg0JX089EVwRRjBF3UvEKsCKlYPcPfXaAb5b5eEJsguc2OosdEnR
X-Gm-Gg: AYBFou238qf9ZhsHKcHaXh6gCK2tkEF1tIdqBEQLrzmPlSPD7f8OJ+v0Jkr8QuSCI9N
	Immav2FMb8hGZCt4gWU4gbvMwI4CL0S+rHSUaDSLM7RPiXQer2OMZ7pYXawkSIG4gBC67qRZYaF
	D/QHvUEIX9xB82qCT0E2DHg0PzHB7m5kx8A/uyzSobZPJEeSGJfWrZq6gbHv1tD1l0rhUTlRitB
	g9srshsGReUd3kzPnUEyGvS4ckaY5uWwjI3Ok+5jNmPBUGt7qAc+zmMnOWgjgBTCSrTTAIrMIdD
	uhguAQQlLIPO+bbwNhRD70r2vV+UXwQXEFKCDmo5B9n+BkRevRW9FO0DxxZ+ayTU+R0dTFVaHRn
	2xAqNb6hAfGSA81ZWUy5fJUkUPzglfLXerhGv4WmiVtoufI1NtRW0L161j6MrSuIUQhEXmLfksV
	z/FhUNtqkv0DdKjh4JlT5jeWcaUProZOgaMRvDvEhqA9U4YxMJ4/D0cypJmxSM+rCoaUpAnchSe
	SKptmHRZz09z6y1BXciGU1CKFj8LQ5kDq6UNQVkeUMWg0kDzJT2YNNRivKhOk2zA45YrBf6qQ8y
	YOEaOlsM3ft30bQafyphnHpcNDlAmXr9wShjXgsh005nAWiEwTJ2aQR095hTpmWG/Sa212s6KEI
	3pZIxPhBvjJDe8et38S9RRIfieYIkPHIY55NM5ECnZiTgLpR265rwxn8He3bvT87KrdqitLToDh
	p4MSXBz2OLFodguNNIxZM/X4kxzLlFKM0cB87dqrYyB/Hztnr7KClN
X-Received: by 2002:a05:6820:858e:20b0:6f9:59ee:cf9a with SMTP id 006d021491bc7-71b1827bdd0mr450903eaf.7.1794953700241;
        Tue, 17 Nov 2026 14:15:00 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b19450af7sm459727eaf.4.2026.11.17.14.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:14:57 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:14:46 -0700
Subject: [PATCH] nvmem: core: validate DT cell bits before allocating the
 name
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-submit-nvmem-dt-cell-name-v1-v1-1-491cee782e6e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2OQQ6DMAwEv4JyrkmDWpD4SsUBEgNuSaBOQEiIv
 zdAjyPP7noTHpnQizLZBONCnkYXQd0SofvadQhkIovsnuVKqQL83FgK4BaLFkwAjcMArrYIiwJ
 8KqPaPC8exohYMTG2tJ71r+rimH+jDkfn32D8znE3XJpoao8QGLFM+hAmX0rZUUg/yA6HdOROT
 nMjvbZyIDev8jocjvRMjuT5Who5aUeGa7/a9x9XvjXn6wAAAA==
X-Change-ID: 20261117-submit-nvmem-dt-cell-name-v1-e51d1f6674dd
To: Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

An invalid bits property makes nvmem_add_cells_from_dt() return before
it frees the cell name. Allocate the name after validating the property,
and fail before invoking the provider fixup if allocation fails.

Fixes: def3173d4f17 ("nvmem: core: Print error on wrong bits DT property")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-219531@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7d4cce8e2742..56e04c030c7f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -819,7 +819,6 @@ int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
 
 		info.offset = be32_to_cpup(addr++);
 		info.bytes = be32_to_cpup(addr);
-		info.name = kasprintf(GFP_KERNEL, "%pOFn", child);
 
 		addr = of_get_property(child, "bits", &len);
 		if (addr && len == (2 * sizeof(u32))) {
@@ -833,6 +832,9 @@ int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
 			}
 		}
 
+		info.name = kasprintf(GFP_KERNEL, "%pOFn", child);
+		if (!info.name)
+			return -ENOMEM;
 		info.np = of_node_get(child);
 
 		if (nvmem->fixup_dt_cell_info)

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git for-fixes
change-id: 20261117-submit-nvmem-dt-cell-name-v1-e51d1f6674dd

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

