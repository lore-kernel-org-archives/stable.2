Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182603F8ED3;
	Fri, 21 Aug 2026 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291530; cv=none; b=cQIXqDstE+b+5jRHJ8TfEl19CoOKxxZ2gsgrS7W0kQ2HEwhOuz181xV0Hd48QVaCaeKa63uwb/CI6RuZQ54ZbGxk6/64hZVFtrmGCas2mUznfSCKnhlcJlFwI4J3mzsVEZ88C3svR2aecfVRroVYeZzCK3i62hT+YOXoFQzcDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291530; c=relaxed/simple;
	bh=k3XidEBmMjOme6/kwpDxvml1MSBKE+KDH/iKbiEFpkk=;
	h=Content-Type:MIME-Version:From:To:In-Reply-To:References:Subject:
	 Date:Message-ID; b=I/hwHigtPa9QDUG0E0FWVu3ErFZLommEL0s1s0ME/wgZBFjLB2DbcVnMQDy9Z1Hylx2dbTZHJGfmwoQZwGvhZsRJ8aQMoUDUZaIrXCvMoePrTKayGtKcr0xA6lnbIK5Z+KMnOV4TdiwfPAEUv8SA2Q5Lutk1aZV3vPIBsQTGnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=longcheer.com; spf=pass smtp.mailfrom=longcheer.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=longcheer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=longcheer.com
Received: from mailsrv01.LongCheer.net
        by unicom146.biz-email.net ((D)) with ESMTP (SSL) id 202608211350450294;
        Fri, 21 Aug 2026 13:50:45 +0800
Received: from [127.0.1.1] (172.16.9.238) by mailsrv01.LongCheer.net
 (172.16.8.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.33; Fri, 21 Aug
 2026 13:50:49 +0800
Content-Type: multipart/mixed;
	boundary="===============5004312235123847154=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: liuqi <liuqi@longcheer.com>
To: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<stable@vger.kernel.org>
In-Reply-To: <870f2627-aeaa-400e-9b6d-ee77eac42be6@mailsrv01.LongCheer.net>
References: <870f2627-aeaa-400e-9b6d-ee77eac42be6@mailsrv01.LongCheer.net>
Subject: Re: [PATCH] usb-storage: prevent concurrent URB submission in usb_stor_msg_common
Date: Fri, 21 Aug 2026 13:50:49 +0800
Message-ID: <5ab39041-295e-4b80-b3a6-52061c6eff76@mailsrv01.LongCheer.net>
X-ClientProxiedBy: mailsrv01.LongCheer.net (172.16.8.231) To
 mailsrv01.LongCheer.net (172.16.8.231)
tUid: 2026821135045031ca3d62ceccaa6121f406099ac6f3a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

--===============5004312235123847154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

QWxhbiwgdGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LiBZb3Ugd2VyZSByaWdodCB0byBxdWVzdGlv
biBteSBvcmlnaW5hbCBleHBsYW5hdGlvbi4KCkkgcmVjaGVja2VkIHRoZSBzeXpib3QgY29uc29s
ZSBsb2dzLCBhbmQgSSBkbyBub3Qgc2VlIGV2aWRlbmNlIHRoYXQgc2NzaV9laCBpcyBpbnZvbHZl
ZC4gVGhlIHdhcm5pbmcgaXMgdHJpZ2dlcmVkIGZyb20gdGhlIGRlbGF5ZWQgc2NhbiB3b3JrIHdo
aWxlIGlzc3VpbmcgR0VUX01BWF9MVU46CgogIHVzYl9zdG9yX3NjYW5fZHdvcmsoKQogICAgdXNi
X3N0b3JfQnVsa19tYXhfbHVuKCkKICAgICAgdXNiX3N0b3JfY29udHJvbF9tc2coKQogICAgICAg
IHVzYl9zdG9yX21zZ19jb21tb24oKQogICAgICAgICAgdXNiX3N1Ym1pdF91cmIoKQoKVGhlIGRl
dmljZSBpbiB0aGUgcmVwb3J0cyBpcyB0aGUgRU5FIFVCNjI1MCByZWFkZXIgKDBjZjI6NjI1MCku
IExvb2tpbmcgYXQgdGhlIGRyaXZlciBhZ2FpbiwgdGhlIG1vcmUgcGxhdXNpYmxlIGlzc3VlIGlz
IHNwZWNpZmljIHRvIHVtc19lbmV1YjYyNTA6IGVuZV91YjYyNTBfcHJvYmUoKSBjYWxscyB1c2Jf
c3Rvcl9wcm9iZTIoKSwgd2hpY2ggc2NoZWR1bGVzIHRoZSBkZWxheWVkIHNjYW4gd29yaywgYW5k
IHRoZW4gY2FsbHMgZW5lX2dldF9jYXJkX3R5cGUoKS4gVGhhdCBwYXRoIHNlbmRzIGEgY29tbWFu
ZCB0aHJvdWdoIGVuZV9zZW5kX3Njc2lfY21kKCkgYW5kIHRoZSB1c2Itc3RvcmFnZSB0cmFuc2Zl
ciBoZWxwZXJzLCB1c2luZyB1cy0+Y3VycmVudF91cmIsIGJ1dCBpdCBpcyBub3Qgc2VyaWFsaXpl
ZCB3aXRoIHVzLT5kZXZfbXV0ZXguIFRoZSBzY2FuIHdvcmsgZG9lcyB0YWtlIHVzLT5kZXZfbXV0
ZXggYXJvdW5kIHVzYl9zdG9yX0J1bGtfbWF4X2x1bigpLgoKU28gdGhlIHN5emJvdCByZXBvcnQg
c3Ryb25nbHkgc3VnZ2VzdHMgYSByYWNlIGJldHdlZW4gdGhlIEVORSBjYXJkLXR5cGUgcHJvYmUg
YW5kIHRoZSBkZWxheWVkIHNjYW4gd29yaywgcmF0aGVyIHRoYW4gYW55dGhpbmcgaW52b2x2aW5n
IHNjc2lfZWguCgpJIHdpbGwgZHJvcCB0aGUgZ2VuZXJpYyB1c2Jfc3Rvcl9tc2dfY29tbW9uKCkg
Y2hhbmdlIGFuZCBzZW5kIGEgbmFycm93ZXIgdjIgcGF0Y2ggZm9yIHVtc19lbmV1YjYyNTAgaW5z
dGVhZC4KClNvcnJ5IGZvciB0aGUgaW5jb3JyZWN0IGFuYWx5c2lzIGluIHRoZSBvcmlnaW5hbCBz
dWJtaXNzaW9uLCBhbmQgdGhhbmtzIGFnYWluIGZvciBwb2ludGluZyBpdCBvdXQuCgpSZWdhcmRz
LApsaXVxaQ==

--===============5004312235123847154==--
