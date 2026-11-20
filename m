Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202744;
	b=zE6koUoZmoR6F/IVTQjWijnsYFvQcTAez7lCOfS4jUQW0QEjGqg9ALlqnzQBo2YSnQ/I
	 G5o9K9/nWduCpxJfz23fvyjtkyqL2cjn2ZnpecH3/Vt9t9sBUtexP2CsQUuC9t0dz9HJL
	 O0pEdi+1HUXVTOAh0iHc35LAOthGNCLRvDRf9eNQITMbz0/jFY3wfMPGg0a9QdDjMC2y4
	 tu647fS7kAKTvGpALrx/buGUPrlnBve4UvX6MgpOVFyjFiDzydrKuYgXrj94pGUJqo4cf
	 7eV4uJ0l/CLUu2ctnKyBGKVHDGKyxkq+nXboav329DwYElAuPFSSxTithhJH9Vwfdiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202744;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IGxBcChm1AqwyrtbybP5NQsmAPR2jz5ajvB71l3cptc=;
	b=KhIiV5sTKI9PzNQVn7imrzYg1I4crq+7IlawNtvLVkH0WFFJFHk1tTWYRTMWSf5METZh
	 qHNYQ7t8OROjArzgfhc7b8bcUpKtgAXNW+4T7Xs5u7L9h4xLqGjt46ZPF1GmBatmtDi3q
	 fJI6SQEg7/onjY2WCIKVWEBbs36bLh6kPXRhwvGRyWYSqB4ixP3uPvFMr9qBMV+qb/J98
	 h9Hk1dVhlu7hlRooiniL0FN8y70oHVK530ndQRTqBD4nIzWyg06KDnqc4r092VlPDZ+LT
	 ++V6jXOq9D5ym6biTc4+gvPM0J2a6+ul9UOX7dL4XdX3/F9lrN8SIHiyI8jg9Y6w14w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=mgJGn0nM;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1133606A6D4;
	Fri, 20 Nov 2026 19:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1133606A6D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=mgJGn0nM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1795202738;
	bh=IGxBcChm1AqwyrtbybP5NQsmAPR2jz5ajvB71l3cptc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mgJGn0nMWprju/SIs27Ow5GJfTSmI/udmVnZpNEIbJV5VZMa/4mNvBmbRkj3AJtzw
	 kGUu9pYbnlM8ovTky2isvIeX/DjSCBjbq7k9h3tH5YHDT9XMdwbVd4epCmwf8n6SjQ
	 1dMvNyi6AbPgbVlxkVy+EujO+srAB+88Aa9Abbzk=
Received: from localhost.localdomain ([240e:3bb:3013:2171:4526:e32a:3de3:2a2d])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 6642AA26; Sat, 21 Nov 2026 03:25:36 +0800
X-QQ-mid: xmsmtpt1795202736t39bl3ee3
Message-ID: <tencent_4D6D752CE33270511C01114C7729C5AE8B0A@qq.com>
X-QQ-XMAILINFO: MJf32pulH481paTj7FqSn/po4DjkRabwV7/4dwVajTTD3kb9iSSAs9qs1aHX/g
	 eoVwXqoiVcPYbKsP3imVQVNGODQvm8QL1oTZsdiTj7+KzuyHncGeF1bxnwbItRQbTzBCmVtIuZY3
	 n/4NCXFHW15jXtJdzmx3Njq/JiyxvQwDGGfWbXLL6GfyzeGa/ZzzxceTDVOzae9OVblaxzJx3HBT
	 H3gJ4Ra80cdPddtfau8pQ1L1EM2AjNFM9WUy9unjTseC3o1y/lpvLj1PfSjR6264cB3Mlx9ZHYmj
	 yzU4Yt89ZbWFQ4LqLrDCHnMXNkrFYDY2B0fA6dnTZsuwkP+OVCK8EdNo2hF8bumeYasHC0THOKX9
	 /Hq8A8WTEXt2iNskIqhJJ5gWiecebSAkOj8Zz6WfLLN7+RmLVzY4eeo1teX5P2qFh98/bnQSgX3c
	 Cd6VXIuZpu1g1qOpeF91IBYApMLWiaEPRqGLmKzLh4LznwrM5RMsiY9kAA13wZ0Li/33HM84fLKA
	 tYPXKNB10ix4785CxtiwI8srIKoftbHgs8r2O+gGYo1/jM3dCj6nHaDT/t5W2Trx7uW2lrxXu34Q
	 oeTO3dDFspHNBGNHV5W6YDgUufT6NhQh/mccQ7iwQVpKxXmCb0myaf81gwB5jzhrcC0VFyYOtJ+q
	 MvRDcih3Ihmmm7NhaomjuzjwX14LAVI1XIpXlBKsTpfL2PlnkM3FJnX+3k2F4qijssh1w+WnLaBn
	 5LFD8VYJqIE90Ttp+20/jk/qla4UBiSKziqgitGiShUnm8IjwjT69IenYo73w1kixPMqXbQFRmDt
	 c2vSq4W7ww77uEtq31eJFBNLkiw4r74NybV4NrTs25s+eLx5KR8H9MFzT0iQlmdpeYaVw4XjHToo
	 NhiyC/ns6MrbP+xEsOy2SaG7ipzShX6tjS4JcxfVMdUUzeS3ZZ+7mlUhfHVjiLfR9W7y5FD6Y6Os
	 DH97q7efKJl+UO7pg806ryXPXPVB5GZLxEM75eCTlF/xdmfUIlsB+7z3aY733MDri3kKW8WPbE0/
	 klBhhSKa+bNz9cy4/jnSXmIBI9adM=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: memoriaru@foxmail.com
To: heikki.krogerus@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	badhri@google.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH usb v2] usb: typec: tcpm: align SOP' Soft Reset handling with SOP
Date: Sat, 21 Nov 2026 03:25:34 +0800
X-OQ-MSGID: <1795204200.cover.tcpm-v4@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <awBIRnc9lBkdVhEK@black.igk.intel.com>
References: <tencent_443620EAE95525A375BB2D8A653406630A07@qq.com> <awBIRnc9lBkdVhEK@black.igk.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

Hi Heikki,

Thanks for catching the broken v2/v3 submissions. The Sashiko review
findings on the resend were all valid, and re-checking the tree showed
my changelog misdescribed the initiator path as well:

- SOFT_RESET_SEND branches on the SOP* type and resets only the counters
  of the channel being reset (PD 3.0 sec 6.3.13, "targeted at a specific
  entity"), not both pairs as I wrote.

So v4 drops the second hunk: unconditionally resetting
message_id_prime/rx_msgid_prime from the responder SOFT_RESET case is
wrong for the same reason -- a SOP-channel soft reset must not clear
cable-channel state.

That said, while re-checking I noticed the responder side of SOP' Soft
Reset looks mis-handled overall in the current tree:

- tcpm_pd_handle_msg() has no SOP* type parameter, so the SOFT_RESET
  case cannot tell which channel the reset came from; it always resets
  the SOP counters and sends PD_CTRL_ACCEPT on TCPC_TX_SOP.

- A Soft_Reset received on SOP' therefore gets its ACCEPT sent on SOP,
  and its prime counters are not reset.

A complete fix would thread the SOP* type through tcpm_pd_handle_msg()
and mirror the SOFT_RESET_SEND per-channel handling on the responder
side. I'm happy to prepare that if you prefer -- it touches more call
sites, so I did not fold it into this resend.

v4 below keeps only the duplicate-check exemption (first hunk), with
the changelog facts corrected.

Thanks,

