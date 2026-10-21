Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598020;
	b=jW+JHUToA7Ljx4luYQLaUL7lAoIi4aoYLxTEbRNPu/20PpgQiME9DrMt2X5PbCMLcPuv
	 k42JYDAWXng7ucXKevI+mHijpKOZrcCRVp8PH4AOw+HoGPMEq9ngwRhN+MK092RfdA3Sd
	 XlPAMPNcwqb/ez7iXSNAchDU4j6TFsDaGWa3FFVjDTVw79fXOYwuojQ4GwcSt4T4IUa8i
	 VElSNG529KjaBLf5BEmCQD4U91ILSXDd3GeG7VgxAIMpOWK8mQrQCwGiBuF4bk9FGDke/
	 3QXNuiZgkj7Mqb+osbu5T4wetv8Lyj3U9kTX0XuTTv+7VPiwBW+OlxfciUSg6OGFC2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598020;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=4CwkvaVkQWrBo1G3WsdyRIUlADdlnSOaTellY/lZOtM=;
	b=U19NYLkrQ7kGQ2g+4/BJMDOK80zZt1++OAY2bukMm8UGyCfaz2uTNwJPVy0rVpd7hnPA
	 Yszlu08A1MPeYFnes4vSWr6iUdQ9SWjgCIQ0GkBCIzZFyFO81uDXgkTbwCRtBBFVPUmVR
	 tO+/jsdsto981Nyd6tRSu7K4P/0lBTS8sF/ame48ba4kUQU8YwGrjxhMO8wxbD/vbtwaT
	 3pwJJ6cZh3lQUBH1hE+7JdDd1CAG4VLbOyypT4IF0v5zwYiwteyhYJUPDvG5zL/qKNIp7
	 Gvq9K3tSXVNVCRhIX3OuiXMdaiFROQae+nGoFa1S6xwwtsTIVYk8AGQSwTOsgZZq5ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jDn0S+kG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD93606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD93606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jDn0S+kG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792598019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CwkvaVkQWrBo1G3WsdyRIUlADdlnSOaTellY/lZOtM=;
	b=jDn0S+kGES8cubW/pJujatSEr5HwU66veopMYCJiEeJMx3/Y6cRCNeMDAOq5SG6Hod0mcN
	q5UtrHJ802hIXgLXsCe0kTcG+mt+nzUHyTXhqU61flnpfd+QVJRcZU2QqNS8uREj19IUxh
	sD6RD8LxhYhQfK4sk9Lr3kTwc/DGm5Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-WmkyJPO7Md2Yz-SkEnAfwQ-1; Wed,
 21 Oct 2026 15:53:34 +0000
X-MC-Unique: WmkyJPO7Md2Yz-SkEnAfwQ-1
X-Mimecast-MFC-AGG-ID: WmkyJPO7Md2Yz-SkEnAfwQ_1792598013
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A6E61800148;
	Wed, 21 Oct 2026 15:53:32 +0000 (UTC)
Received: from loberman-thinkpadp16gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C605180029C;
	Wed, 21 Oct 2026 15:53:30 +0000 (UTC)
From: Laurence Oberman <loberman@redhat.com>
To: stable@vger.kernel.org
Cc: jannh@google.com,
	serge@hallyn.com,
	paul@paul-moore.com,
	brauner@kernel.org,
	gnoack@google.com,
	mic@digikod.net,
	mkp@kernel.org
Subject: Re: [PATCH 5.10.y 01/16] cred: clarify that task_struct::cred is only for the current task
Date: Wed, 21 Oct 2026 11:53:27 -0400
Message-ID: <20261021155327.2739540-1-loberman@redhat.com>
In-Reply-To: <20261021154705.2737365-2-loberman@redhat.com>
References: <20261021154705.2737365-2-loberman@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Please ignore this patch and 02/16 ("ns: Free anonymous mount namespaces
via ns_common_free()"). Both were sent by mistake, by a git send-email
revision range picked up from the wrong tree; 03-16 were not sent.

The only intended patch in this thread is
  [PATCH 5.10.y] scsi: st: Fix use-after-free race between st_remove() and st_open()
  <20261021154705.2737365-1-loberman@redhat.com>
which stands on its own.

Sorry for the noise.
Laurence

