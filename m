Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803A38D415
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274320; cv=pass; b=TY0HhbL2oxbMJnC4ODhb6oWjK6Xya1mozMCtMVuJ0jLik6D8EzthMMzlFnuoKkKQXyc7DmnRMP/05xg2l1KtdRR16T0TtMamXdp5PUdQYmFkaCjpw1JLqMvOwyHPJTsPaPlBqGWw6z0EIoGqM4rRCnX1ZIIAWxtmfHSrozMtnQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274320; c=relaxed/simple;
	bh=NIxKP6TZ2tnFViW03A80ROCVjYwpvgXFgLDGX0G5DlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3Dti+a27+mpuBCLR18G5m8c2FhNRGaIDNFCSUYWkGlZh5nC1pAsEDVosgXjsNTLnrxGISX8ifr7or+IsfWFt9lNsgHF2K29TTUarwTAq38e7HQssQSi2vtFKq8lNh2Lz9eVmVE5cbam6mPBvNhAMg+MaCSWpYlt5q5oDyZ0UPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFC4uFwB; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFC4uFwB"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c7e3a2332so1180100d50.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 07:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788274317; cv=none;
        d=google.com; s=arc-20260327;
        b=BtL7Ip7wUTwfRNSuhQlky9R0PcgacXFVwU3JIA3shKlyNY90Jik9o3Plm5ElbTEFtr
         aeqBK9w0n3xjxKMzvB6wizgc6RsbPES395Vgj8wLO4KazHzpaIEDSX2RoxEPMi9L9jJx
         aKut8T3lcXe5rEwyCwONQ317KUl/Bmx+1xXDpyPT3wb1S9VQ8S/O/eL6Sf+FuT0ej5IY
         hhUMLbg0ZSl3RpeCEDWIfKRrBIgBAZI09r+7isVqbzs4dDIT2FRFOvQ+PcW50AJFGK+V
         EMXYczyDxHQ94eyUFRko1AryQch/hTESTJJz0eYpQiMSBVhpKi2cvS7+yuEtUIpSqgK2
         MiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zEecowGV0URQUsGJB/9dYqORlnjv4pnsG8QOqOs5tM=;
        fh=F2oSNWaqyqh7PxMWns6h7oaj9g93dfHq5yVuzF/KYEU=;
        b=pTsc64uwr0/2PKNxYDUuyebb14Nl2SgeLUecMDUrVE6qF3GvaxYn5KH3BbTTvn9CWQ
         BcNToxYttz284UqYQWNzDCQ9PgC4E9+QydYx3nDhmYfoqX4/ifSo9o8bI8y0rfz6pvrn
         IAQ4WKO3geu8UfLV+TBA1fR2rC7JxEfe5+DxVWHVcMnYlJQxuQdUccLh3TkwR8LGNEnp
         vvCHC43ivSt9w9z2SqIRxIGgDWYyM5T8oOeu1PvlyjU7cVLTEoqqxKrIkA/Mer6/m5Vi
         otDvLtFDmbBxtCr8+1CeJzVnwQvK0xO6N0dKY8ydeGCCn7fPJWmB6PR6OCdqE51MZhGB
         pG8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788274317; x=1788879117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7zEecowGV0URQUsGJB/9dYqORlnjv4pnsG8QOqOs5tM=;
        b=TFC4uFwBZ8vt70wQxkNT1YRMIM+4KNpQ11GJH7r6MK+9n2bt0NQkqnSJqoSbyWfiv7
         2RBg7DmAzdfsZkDAPrHfPy10970vUvRc6HjDnUdPWbNVZu7I1txhaEY5VcRsNSGTmCoO
         qP6OXZ04RzMZUhCkxyAthZ9nFjFdMundMP+84XWpBjUWTtdxfNOm3/l+jF59tjXu6tAW
         fIfTObJopb3BLPb1GXOdufm8e3CDdHuxnSi8hKSNPEMgzC/O4AsTFg25jsrPDQFBTD7m
         uCUKjcfRXAkNotWQ90tr32liskDn6cptUSDfadASdWZkPLLod9Ua0Zt8cpE4MDb6rwCe
         5g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274317; x=1788879117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7zEecowGV0URQUsGJB/9dYqORlnjv4pnsG8QOqOs5tM=;
        b=XikUggLHYAeuWrJ+PbaccFFZsyD7EDBh/lRImH8c01vq7Vj0ZVwa66/9tN/MSSrhN0
         DwCsWs4N3amqOg6LxJOteRPhEgj6rQNcMe9V7dcJzh33Dh+fepWRs59myLABz9QcaqAX
         DT9vfaOykcOWRhEFil7p2yFoBDtTvBnVmu1+9Fi0MH8DdI86qmZCk3NQECFvjHETJCjn
         216CwOjAB9ftyRI5O0Jjcf1OfoAIJUJA81L2RxtDUTB9fwx1kCHhHsC0/nxRGQ1Q3Qf5
         kNDfvatupXXOmDPxAbHVINwtdYTY5kZPBABW86vyz18zEqfuuTaV27jIgL1wdjuco4QS
         04bA==
X-Forwarded-Encrypted: i=1; AKwUvBwso244Zi8i2MxYjevZyUNXuDqTtQ/oji99fjBOuMNLyfS8xfgIUE2LGObJ1e+CiVOAbkBQeVw=@vger.kernel.org
X-Gm-Message-State: AFuF++mMrJ3DYsa+b8HfQw/nFAE/fdMMnw38wKSL0le2xLtjYyfO5i5u
	8RfIQ1E60gjDRVedP0O34WDv2v+2EyzOpye4oR1lqg/bQp7VnIGlDNtPcOf4qZ1Chc76Lmj6xHx
	vXtrXq+PlKzWFDgzPD9sHui2jdqapPlU=
X-Gm-Gg: AYBFou0c4SWgEThdXbzWiCxZe5Pug0nUKStD9esau92PsL6FUpzh+U54gH+Fwy+8Xfd
	0m6q7x7D1++KlapvmjkDvt68Mem10Oquo9v+m/nImvx61MjnFwc6joetWmusy6b4LXOsDu5pKuf
	6k3hrTnGbnkWGWEY7QRuyO0mkioMJVLD9ggHRmxUZNoPjkzn4IKV5TNGf3udEr7gjZWalOs8SyJ
	pLSgApVXncg8I2jIoztRI3EYdpMcg57/9uM0oNTX5E2MD/6EXA1KyKpMLm9IyHgJLRqYQHTdWL/
	lh23B5wK9ZIZkpp2lsQ+e1WojB5bOUu+WexzwYJycfuGstZbiUftfs1LPH6plxUF7QpVPrg6rR+
	+W4ENW4+KenAVlduEOv9foODSupDE
X-Received: by 2002:a05:690c:c3c4:b0:81d:c233:aea0 with SMTP id
 00721157ae682-85d6a2e184fmr110198737b3.18.1788274317111; Tue, 01 Sep 2026
 07:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831090232.1726063-1-valentin.kindschi@fiveco.ch>
In-Reply-To: <20260831090232.1726063-1-valentin.kindschi@fiveco.ch>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Sep 2026 10:51:44 -0400
X-Gm-Features: AcwNN1WJq7njKzkqAQuAxRsZa-_LfUiBoeox2YdRn2bi-oxKnMKFo1GT_Jvq8ys
Message-ID: <CABBYNZKp=a8+YQDj_b=jcmA1tVxW8HJG8yvsCFQHuDghZPmFzw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_sync: pause advertising for the scan
 address update
To: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Valentin,

On Mon, Aug 31, 2026 at 5:03=E2=80=AFAM Valentin Kindschi
<valentin.kindschi@fiveco.ch> wrote:
>
> hci_active_scan_sync() calls hci_update_random_address_sync() with
> require_privacy set on every active scan start, which generates a
> non-resolvable private address and programs it with LE Set Random
> Address.
>
> BLUETOOTH CORE SPECIFICATION Vol 4, Part E, 7.8.4 states the controller
> shall return Command Disallowed (0x0C) for LE Set Random Address while
> legacy advertising or scanning is enabled.
>
> Advertising is only stopped beforehand when LL privacy is in use.
> hci_pause_addr_resolution(), called just above, returns early when
> !use_ll_privacy(hdev), so its hci_pause_advertising_sync() never runs.
> On a device that advertises while active scanning - a peripheral that is
> also a central - every scan start therefore issues a
> command the host can already know will be rejected:
>
>   Bluetooth: hci0: Opcode 0x2005 failed: -16
>
> The address write is not retried either: hci_set_random_addr_sync()
> defers only when hdev->random_addr is already set, and it never becomes
> set because the write keeps failing, so HCI_RPA_EXPIRED is not used here.
>
> Observed on a BCM43455 with Privacy=3Doff, one advertising instance and
> continuous active discovery, at the scan restart period (~10 s):
>
>   < LE Set Random Address  Address: 02:16:91:90:F1:D4 (Non-Resolvable)
>   > Command Complete       LE Set Random Address, Command Disallowed
>   < LE Set Random Address  Address: 26:90:57:96:9A:3E (Non-Resolvable)
>   > Command Complete       LE Set Random Address, Command Disallowed
>   < LE Set Random Address  Address: 16:32:01:BC:B5:CE (Non-Resolvable)
>   > Command Complete       LE Set Random Address, Command Disallowed
>
> Pause advertising for the address update regardless of privacy, and
> resume it on every exit path. Previously the resume was guarded by
> use_ll_privacy() and only reached on the error path, which matched the
> pause being privacy-only.
>
> One caveat this widens: when HCI_ADVERTISING is set,
> hci_pause_advertising_sync() also clears HCI_DISCOVERABLE and zeroes
> discov_timeout, and hci_resume_advertising_sync() restores only
> HCI_ADVERTISING. That side effect previously happened only with LL
> privacy; it is now reachable on every active scan start, so a device made
> discoverable through mgmt while repeatedly running active discovery would
> lose discoverability. Restoring it belongs in the pause/resume pair rathe=
r
> than here, but it is worth flagging.

Sashiko flagged this, so I think we need to fix it; otherwise, the
controller will not be considered discoverable upon resume:

https://sashiko.dev/#/patchset/20260831090232.1726063-1-valentin.kindschi%4=
0fiveco.ch

> With the patch, the same scan restart on the same hardware:
>
>   < LE Set Advertising Enable                            Success
>   < LE Set Random Address                                Success
>   < LE Set Scan Parameters                               Success
>   < LE Set Scan Enable                                   Success
>   < LE Set Advertising Parameters                        Success
>   < LE Set Advertising Enable                            Success
>
> Over 35425 records / ~4 min of btmon with continuous active discovery and
> advertising enabled there were no Command Disallowed responses of any
> kind, against one per scan restart before. A central could still connect
> to the device, confirming advertising is restored after the pause.
>
> A second capture on the same device, 221 s with an out-of-range peer
> causing two cancelled outgoing connections, shows the same result under a
> different mix of traffic: 2 LE Set Random Address, both Success, and no
> Command Disallowed of any opcode.
>
> Tooling disclosure (Documentation/process/generated-content.rst): an AI
> coding assistant was used to investigate this and to draft the change;
> the patch text and code are its output, reviewed by me. Inputs were btmon
> captures and kernel logs from the affected device, with the request to
> identify what re-issues LE Set Random Address every ~10 s and to fix it.
> Three earlier explanations it proposed were discarded after being checked
> against the captures: bluetoothd restarting service discovery; RPA
> rotation (excluded, Privacy=3Doff); and the static-address branch of
> hci_update_random_address_sync() (excluded, both random_address and
> static_address read 00:00:00:00:00:00). The cause was only established
> after decoding the command payloads, which showed a freshly generated
> non-resolvable address per attempt. Testing is as described above, on the
> device, using btmon and a second device to confirm connectability.
>
> Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVER=
Y")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5 btmon
> Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
> ---
> Changes in v3:
> - Resend, no code change; v2 had no reply. Rechecked that it still applie=
s
>   to bluetooth-next.
> - Added the second capture described above, taken with the two patches fr=
om
>   the "endless adv params retry" series applied, since in bluetooth-next,
>   confirming the fix holds with cancelled outgoing connections in the mix=
.
>
> Changes in v2:
> - Rebased onto bluetooth-next: mainline renamed use_ll_privacy() to
>   ll_privacy_capable(). No functional change.
>  net/bluetooth/hci_sync.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6244,6 +6244,14 @@ static int hci_active_scan_sync(struct hci_dev *hd=
ev, uint16_t interval)
>         if (err)
>                 goto failed;
>
> +       /* LE Set Random Address is disallowed while advertising is enabl=
ed, so
> +        * pause it for the address update. hci_pause_addr_resolution() a=
bove
> +        * only does this when LL privacy is in use.
> +        */
> +       err =3D hci_pause_advertising_sync(hdev);
> +       if (err)
> +               goto failed;
> +
>         /* All active scans will be done with either a resolvable private
>          * address (when privacy feature has been enabled) or non-resolva=
ble
>          * private address.
> @@ -6272,13 +6280,18 @@ static int hci_active_scan_sync(struct hci_dev *h=
dev, uint16_t interval)
>         err =3D hci_start_scan_sync(hdev, LE_SCAN_ACTIVE, interval,
>                                   hdev->le_scan_window_discovery,
>                                   own_addr_type, filter_policy, filter_du=
p);
> -       if (!err)
> +       if (!err) {
> +               /* Advertising was paused for the address update above. *=
/
> +               hci_resume_advertising_sync(hdev);
>                 return err;
> +       }
>
>  failed:
> -       /* Resume advertising if it was paused */
> -       if (ll_privacy_capable(hdev))
> -               hci_resume_advertising_sync(hdev);
> +       /* Resume advertising if it was paused. hci_resume_advertising_sy=
nc()
> +        * is a no-op when hdev->advertising_paused is not set, so this c=
overs
> +        * both the privacy and the address-update pause.
> +        */
> +       hci_resume_advertising_sync(hdev);
>
>         /* Resume passive scanning */
>         hci_update_passive_scan_sync(hdev);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
