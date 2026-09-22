Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6DF3BAD93;
	Tue, 22 Sep 2026 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108810; cv=none; b=hrrIR+wRIXDyur0pkouwnAYXgTyJDUpo9nziICw5ckdsDI1jra07apmu1J5/4NXm327YbkNAhx449MJKnKj8v+FDfMT8XzdB+fgS6AHKnX6JmflDdtAVe3iVjQjZRwGC4XQsMcnbZUvSpGn32qXRqjZyxnERSmou7Wssbg6Dl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108810; c=relaxed/simple;
	bh=c3fDBEojDiS0c29GwjanENL1WZLOMVRD9r3CQ7R/Ht0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFv7AEkBhArGnpek/OEIHakt2Cr9jwrbYRF9AG3+zQVgtBLq3uA2v2qb9z+i9VMvJZDQlN820f3c/bgrNYAt7N9fFrsY7T46wKULQgKjpGUAKoq0E2869rMEyJunqSgvFeRoHVay77fxL7TRNbNqeta9BOA07MR1ijDovSfHQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=NxcNCUDz; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="NxcNCUDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790108784; x=1790713584; i=w_armin@gmx.de;
	bh=+U6b9pclhkTtsqgTtIP77UM5PXwM1BqE1C6EiU9I8V4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NxcNCUDzKoqDgkqCS7FkJBUimcLQLu+B49ELi4bRwBG7n2RFPedvqpd81gVV32Wm
	 b0O9ylWQ1MD2e+C56h4VRJrn3C+5rNewpWbdsvrvClV6g257NkgPezeRHW7kEOTrR
	 cAcaPnqg5CTC63U3MmnJOfodxbNneU7w9FUYBrzjyyxcMck+GqmW3kJ369BRwzq73
	 CCih0dhnt0+IkJuW3ZQHNMJPkBc8TLUXiU93B1ZjuBHsIPFRh6q/PY/U0oUo5vmbR
	 42AlibdoCAQCfRdzIQOyG3O57ldQ2sydX3ETMDGX8oZnx1VpK56Yr4Fwy+5k1RL+H
	 p8koldLsSF8tMoa5wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNpH-1wUWaL34mL-00jdka; Tue, 22
 Sep 2026 22:26:24 +0200
Message-ID: <11a7e666-28e7-4219-970e-f4d5b37b64b3@gmx.de>
Date: Tue, 22 Sep 2026 22:26:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: asus-wmi: Serialize WMI evaluations and
 drop redundant rfkill lock
To: Marco Scardovi <scardracs@disroot.org>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Corentin Chary <corentin.chary@gmail.com>, stable@vger.kernel.org
References: <cover.1789722252.git.scardracs@disroot.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <cover.1789722252.git.scardracs@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OxjLQR7jR8bhpjHomm8NXRq6lXERIgubN6UvSrDgwR0QWP9QaBo
 im9NV8AzDy6Bq3Gzyy2V1k+FncgHNVr2hoPMI4wwMFqhnyLJa4Xff8LAgau2BBNIPtOBmT1
 GJbtRE5Ph5fgyVuEHPaVuVEaB+nxvRDo8NNVRDLfq6XlnSagpr8dro1J9sMXBDOZLVAOy8N
 ynZj/XabB9PyOw2lZWQIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:amVK8TozzyA=;hOLJVsRm9TvmFKZ1QS+KzIjwOjU
 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
 /bDId+uC8z2ir

Am 18.09.26 um 11:14 schrieb Marco Scardovi:

> ASUS WMI management methods share a single firmware/EC mailbox that is
> not re-entrant. Concurrent evaluations from ACPI notify, sysfs, HID
> callers (hid-asus, asus-armoury) and debugfs can trigger nested SMIs or
> corrupt the mailbox.
>
> This series serializes every ASUS_WMI_MGMT_GUID evaluation through a
> global mutex, then drops the old per-device wmi_lock that only covered
> WLAN rfkill hotplug.
>
> The mutex is static because asus_wmi_evaluate_method() is exported and
> callers outside asus-wmi have no struct asus_wmi. Fixes points at the
> original shared evaluate helper rather than the later export, so stable
> backports are not limited to kernels that carry that export.
>
> Patch 1 introduces asus_wmi_evaluate_method_locked() and routes method3,
> method5, method_buf and show_call through it.
>
> Patch 2 removes the now-redundant wmi_lock and the pass-through
> asus_rfkill_wlan_ops.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Link: https://github.com/OpenGamingCollective/asusctl/issues/328
>
> Marco Scardovi (2):
>    platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex
>    platform/x86: asus-wmi: Remove redundant per-device wmi_lock and
>      duplicate rfkill ops
>
>   drivers/platform/x86/asus-wmi.c | 67 +++++++++++----------------------
>   1 file changed, 23 insertions(+), 44 deletions(-)
>
