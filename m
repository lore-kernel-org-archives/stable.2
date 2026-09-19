Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ACD29408;
	Sat, 19 Sep 2026 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789784378; cv=none; b=jD1DAgie2jCyEDXO+4mXUO9jKckmt/hF+8OCWchXF0ZDqksrh21dPF2RB1Ml36xUeJv1hnbsZDhApJMfpMatpUuN600vXCdqNx3XvluJXaXPhCq/WAeIOkuz1sbRNLTPAz04x4OM/rkKpkL/2LUu+EpYM4UT0aWvh2Bn4e683xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789784378; c=relaxed/simple;
	bh=tIcyqnTz9C5q73h/9R0oqd0NquYa0bopkiAtCDv3jqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJsdYIc0apGW2MOWBhN+mtLLJxi6w7ifg+y6Hxpe3tPI2kHHYQZijqBpOASSD/KxIKYH1FyVrP5WLNDlgUDHiTARNcnHI3aqbOGZw47msGtj/9+GK7FNRtQJPV1MvaGMK5UHRUQrBOhME1MyN2vC9pKZ0PzRF/3wD0OcmTVxrCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADH+EIg8a1qEGujCA--.21748S2;
	Sat, 19 Sep 2026 10:19:12 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: akpm@linux-foundation.org
Cc: gregkh@linuxfoundation.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	shyamsaini@linux.microsoft.com,
	stable@vger.kernel.org,
	xujiakai24@mails.ucas.ac.cn
Subject: Re: [PATCH v2] params: serialize lookup_or_create_module_kobject()
Date: Sat, 19 Sep 2026 02:19:10 +0000
Message-Id: <20260919021910.211375-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918135735.678bac31c1771e0226c00822@linux-foundation.org>
References: <20260918100712.3124994-1-xujiakai24@mails.ucas.ac.cn> <20260918135735.678bac31c1771e0226c00822@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADH+EIg8a1qEGujCA--.21748S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1kWF15uF15Xw4fAF43ZFb_yoW8Zr43pr
	ZxXr13W3yDWrWkAa1kZFs8Wr1rCr93ZFs0gFna9ry3Cw15ur1SyFyftw15KF4UGrs3Jr40
	qF15tr15KFWDuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

Hi Andrew,

Thanks for the review.

> You're sure we there's no race with module removal as well?

Yes.  The two kobject populations in module_kset have different
lifecycles, and neither can race with the serialized lookup-and-create
in a harmful way:

1. The kobjects this patch serializes belong to built-in modules.
   lookup_or_create_module_kobject() has three callers:
   kernel_add_sysfs_param() and the boot cmdline paths, which are all
   __init and run before concurrency exists, and module_add_driver()
   at runtime.  Once created, a built-in module kobject is never
   deleted: nothing in this path ever calls kobject_del(), and
   module_kobj_release() only completes ->kobj_completion (it does not
   even free the object).  So there is no removal side for these
   kobjects at all.

2. Loadable modules create a separate kobject per module
   (mod->mkobj, in mod_sysfs_init()).  A loadable module cannot
   collide with the lookup either: mod_sysfs_init() itself does
   kset_find_obj() first and refuses to load when a kobject with the
   same name already exists ("module is already loaded"), and
   add_unformed_module() checks for name collisions again under
   module_mutex via module_patient_check_exists().  So a loadable
   module never registers a same-named kobject while a driver
   registration holds our mutex, and free_module()/mod_sysfs_teardown()
   only ever kobject_put() their own mkobj.

3. Even if a concurrent kobject were being removed from module_kset,
   kset_find_obj() uses kobject_get_unless_zero(), so a dying kobject
   whose reference count has already dropped to zero is simply not
   found and we would create a fresh one.

The only remaining window I can see is within kobject core itself
(between kobject_get_unless_zero() and release), which is not this
code's responsibility to serialize.

> minor: this could be static inside lookup_or_create_module_kobject().

Sure, will do in v3.

Thanks,

--
Jiakai Xu

